CREATE TABLE Steps(
   id                 VARCHAR(40) NOT NULL
  ,eventtime          DATETIME  NOT NULL
  ,eventtype          VARCHAR(100)
  ,convid             VARCHAR(80) NOT NULL
  ,tenantname         VARCHAR(100)
  ,tenantid           VARCHAR(100)
  ,dialogname         VARCHAR(100)
  ,speaker            VARCHAR(100)
  ,stepid             VARCHAR(100)
  ,steplabel          VARCHAR(200)
  ,stepresponse       VARCHAR(1000)
  ,steptext           VARCHAR(1000)
  ,stepresponseindex  INTEGER
  ,stepresponseentity VARCHAR(1000)
  ,dialogoutcome      VARCHAR(100)
);

CREATE TABLE Messages(
   id            VARCHAR(40) NOT NULL
  ,eventtime     VARCHAR(28) NOT NULL
  ,eventtype     VARCHAR(100)  
  ,convid        VARCHAR(100) NOT NULL
  ,tenantname    VARCHAR(100)
  ,tenantid      VARCHAR(40)
  ,dialogname         VARCHAR(100)
  ,speaker       VARCHAR(100)
  ,text          VARCHAR(2000)
  ,dialogoutcome  VARCHAR(100)
);

CREATE TABLE MultiChoiceAnswers(
   id            VARCHAR(40) NOT NULL
  ,eventtime     VARCHAR(28) NOT NULL
  ,eventtype     VARCHAR(100)
  ,convid        VARCHAR(100) NOT NULL
  ,tenantname    VARCHAR(100)
  ,tenantid      VARCHAR(40)
  ,dialogname    VARCHAR(100)  
  ,label         VARCHAR(100)
  ,score         int
  ,entity        VARCHAR(200)
  ,[index]       int
);
