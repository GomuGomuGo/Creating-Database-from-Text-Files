### Create ToppGene DataBase
library("sqldf")
library("data.table")
library("RSQLite")
Coexpression <- fread("Coexpression.txt",sep = "\t")
## Read Downloaded Text Files 
Cytoband <- fread("Cytoband.txt",sep = "\t")
Disease <- fread("Disease.txt",sep = "\t")
Domain <- fread("Domain.txt",sep = "\t")
Drug <- fread("Drug.txt",sep = "\t")
GeneFamily <- fread("GeneFamily.txt",sep = "\t")
GeneOntologyBiologicalProcess <- fread("GeneOntologyBiologicalProcess.txt",sep = "\t")
GeneOntologyCellularComponent <- fread("GeneOntologyCellularComponent.txt",sep = "\t")
GeneOntologyMolecularFunction <- fread("GeneOntologyMolecularFunction.txt",sep = "\t")
HumanPheno <- fread("HumanPheno.txt",sep = "\t")
Interaction <- data.frame(Interaction)
MousePheno <- fread("MousePheno.txt",sep = "\t")
Pathway <- fread("Pathway.txt",sep = "\t",colClasses = "character")
PPInteractions <- fread("PPInteractions.txt",sep = "\t")
Pubmed <- fread("Pubmed.txt",sep = "\t")
TFBS <- fread("TFBS.txt",sep = "\t")
Genes = sqldf("SELECT DISTINCT symbol, gene_id FROM MousePheno
              UNION
              SELECT DISTINCT symbol, gene_id FROM HumanPheno
              UNION
              SELECT DISTINCT symbol, gene_id FROM Coexpression
              UNION
              SELECT DISTINCT symbol, gene_id FROM Cytoband
              UNION
              SELECT DISTINCT symbol, gene_id FROM Domain
              UNION
              SELECT DISTINCT symbol, gene_id FROM GeneOntologyBiologicalProcess
              UNION
              SELECT DISTINCT symbol, gene_id FROM GeneOntologyCellularComponent
              UNION
              SELECT DISTINCT symbol, gene_id FROM GeneOntologyMolecularFunction
              UNION
              SELECT DISTINCT symbol, gene_id FROM Interaction
              UNION
              SELECT DISTINCT symbol, gene_id FROM Pathway
              UNION
              SELECT DISTINCT symbol, gene_id FROM TFBS
              UNION
              SELECT DISTINCT symbol, gene_id FROM Pubmed
              UNION
              SELECT DISTINCT symbol, gene_id FROM DrugTrainingData
              UNION
              SELECT DISTINCT symbol, gene_id FROM DiseaseTrainingData")

## Changing the Column Names of the table Genes
colnames(Genes) = c("symbol","gene_id")
Genes = unique(Genes)
drv <- dbDriver("SQLite")
con <- dbConnect(drv, dbname = "ToppGeneDataBase.db")
dbWriteTable(con, "Coexpression", Coexpression)
dbWriteTable(con, "Cytoband", Cytoband)
dbWriteTable(con, "Disease", Disease)
dbWriteTable(con, "Domain", Domain)
dbWriteTable(con, "Drug", Drug)
dbWriteTable(con, "GeneFamily", GeneFamily)
dbWriteTable(con, "GeneOntologyBiologicalProcess", GeneOntologyBiologicalProcess)
dbWriteTable(con, "GeneOntologyCellularComponent", GeneOntologyCellularComponent)
dbWriteTable(con, "GeneOntologyMolecularFunction", GeneOntologyMolecularFunction)
dbWriteTable(con, "HumanPheno", HumanPheno)
dbWriteTable(con, "Interaction", Interaction)
dbWriteTable(con, "MousePheno", MousePheno)
dbWriteTable(con, "Pathway", Pathway)
dbWriteTable(con, "Pubmed", Pubmed)
dbWriteTable(con, "TFBS", TFBS)



