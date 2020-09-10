Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D71A2654AE
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Sep 2020 00:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725925AbgIJWAN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 10 Sep 2020 18:00:13 -0400
Received: from mail-bn8nam12on2060.outbound.protection.outlook.com ([40.107.237.60]:10080
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730099AbgIJKo1 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 10 Sep 2020 06:44:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m1mW597Jv21LrWD6UqtMDBTocGHx0/IO8WbjHLJKTH+saLfMgJanS9HjHZ2W9zUMNQ3sbSndJ1KikKlJQkgcdGob9UVFIpKytva1qOaBfk2w1RsfV4Ooy9kSkORS2sk8LU85yxLf56SywXY5LlwF7Nf2yFVLz3TSTWGYGY3/gucr2xaU77pisEkFDU8/oW2Bq28Sxi00SgohhHLuThJdqz34qQKJZsOaqFL9/Jl3bvZwe7szqqY5ETZLq3urjAnPhEJq0ADw4l+8aW7OLTDmpfSjY+EcoU/CbGFkfXPW51BLmgM10Z7LOB9ObgnifqSFflTt849ZKgo9Su91cGLzLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W9X2XoooE1ZGtXFc7HiH4o7Ntp9X+LreW4l/6KNnf94=;
 b=dAic5THLZQGtVHMsPAQyMPjDFxX5oyNPWWUGFI6WGM/yy9qXbafFC6Jd2B/0NSJ7l6ua3pTBFUa0iHf565KgXy4A91XBWcgF9jlGCLGEywz87WyiyX0DbXp0zryfhAbpj/NxSdt6C8KzGKEY1ZjtasKq+P8TQjA/stmUYKbrZrvbnLXvjjWJqG2pFl7y6EqBHp0JjJFolMZBLwvltyP34XNnLz/8+4NK/ntZ1fm2RQ/hzbLCblYO1V7kzWJ9YByKw3KqGz6wEhsMZoTwaYe778Jxphu1ZppCgPD4DZGOf61h1GhgXItnIjp1DhGFEsswNlonki+JkKRP2G0Qx9+n2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=openfive.com; dmarc=pass action=none header.from=sifive.com;
 dkim=pass header.d=sifive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W9X2XoooE1ZGtXFc7HiH4o7Ntp9X+LreW4l/6KNnf94=;
 b=Nf9JdC1C5PxC4+DiPnnRO/YlHvk20eV6v5mh1tQ33HT4yx3rSt+NmPNLyJ0h/Yc6sW+ZeN4VAuSZPBBsteHmc/x/XPjV9LN0ATLxshPCe+XonPtDcwflyj9vM8C+2P5DUJTUMXL/Qtf6HVTFXgfnqwhflihFzOo0sILjTPkdz4k=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=sifive.com;
Received: from DM6PR13MB3451.namprd13.prod.outlook.com (2603:10b6:5:1c3::10)
 by DM5PR1301MB2106.namprd13.prod.outlook.com (2603:10b6:4:32::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.5; Thu, 10 Sep
 2020 10:44:24 +0000
Received: from DM6PR13MB3451.namprd13.prod.outlook.com
 ([fe80::a48a:1f7c:267c:876]) by DM6PR13MB3451.namprd13.prod.outlook.com
 ([fe80::a48a:1f7c:267c:876%7]) with mapi id 15.20.3370.016; Thu, 10 Sep 2020
 10:44:24 +0000
From:   Sagar Kadam <sagar.kadam@sifive.com>
To:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com, tglx@linutronix.de,
        jason@lakedaemon.net, maz@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        aou@eecs.berkeley.edu, yash.shah@sifive.com,
        Sagar Kadam <sagar.kadam@sifive.com>
Subject: [PATCH v1 0/3] convert sifive's prci, plic and pwm bindings to yaml 
Date:   Thu, 10 Sep 2020 16:14:01 +0530
Message-Id: <1599734644-4791-1-git-send-email-sagar.kadam@sifive.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: BMXPR01CA0087.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::27) To DM6PR13MB3451.namprd13.prod.outlook.com
 (2603:10b6:5:1c3::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from osubuntu003.open-silicon.com (159.117.144.156) by BMXPR01CA0087.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:54::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3326.19 via Frontend Transport; Thu, 10 Sep 2020 10:44:18 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [159.117.144.156]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e1ef478-9a0f-4fc4-9019-08d855767b95
X-MS-TrafficTypeDiagnostic: DM5PR1301MB2106:
X-LD-Processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1301MB2106A2A94362F73A5D64EB0797270@DM5PR1301MB2106.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kUJbS4YG4D98hiHmLt2ay6Tf15pPalZm+WIsSm6JUmrfNGIOenJGeJ53VjtDac85tcjK5s4XaQ6a7VMN02VdAWQP3rqnJKWqx6/Jdr3lcVwrMl1QVMF2d2Q7zvXBmMYWpirYFE5MGuwdBweUiVLk4tW+p7MfnAIv1ZqaFGkz+MlqV0SSnQezPGjnGR33aiidZCFH8SWeiX+40xB7R9iCnj1cYbMslpPxV3bmWPgCOZhdZgJx45LzrnpMP4/O++yebTKash7zvGcvZTbsJzRyjA7qvupR+S+fBkXAhRtYePrNX1QFepsLR78U3SCzLW/i4FTkPTEPhhfRSlJlFKtWbR2nX+98e8dbBmg2BPfh6ApZ7hwJsXxSqDX323LyF8f3g0F30EHYKFhTKDCdVNmf1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB3451.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(39850400004)(346002)(376002)(136003)(366004)(396003)(6666004)(6512007)(316002)(4743002)(26005)(966005)(8676002)(6486002)(66556008)(66476007)(52116002)(2616005)(956004)(186003)(66946007)(5660300002)(4326008)(42882007)(107886003)(8936002)(36756003)(2906002)(478600001)(83380400001)(6506007)(83170400001)(7416002)(16526019)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 2WgOgmhh8sVnvYy3MQYyiRHlTAIyxCfG5ScEDIT5VIfchf931QW/n4K7q0rMA2oEaxvXLpkUIOSIVJDRAxStXr2js2NiL7vMQQKeKFxOXKsSVw9boZC7DlFTCK1a3hJhOpklO75v/wOFa/gBJVDUpsEEt9WMAtHNIVp5419ccZ/z4gPx2aqiYyUAM3fcrc26dvKJmaTw6VIwcTwKfW7DlaIfmou7GYYXgzDLwUCXydw3l1sUJs2ZI9zlUwUw0pBNZllFbEwSunIqC6pkSquRGwo9t4jmT+wGq22Nu5kPS7mYuFBTW8YCt+fppmkxubRvRaWZhrxu1D/CM4a2UkjRDMdAIxocmDLcccPodjehU88N167cWKBo2rnZHrmUBJS/w1YgPX2fiioiMiMQe0cVW3KVhlz79mRxuDfKq7QnUqX1m+TdisIxiDapTPjOTtBhjkNWnv2apZrpBo4T1CWYGCsC3uyyBw9VoCh3iAQf9GggM+VUR/XRMSYLa8Ag+g7jhd8U7WvvzpOFHHPrVOKV/Fw9K08S7P/hYkdLF5SSJvpHrLHLKDszmhJ+8/SsbGv5vZ7Lu8Y9gOeo0WnB7FlbhEx/NR1xonU06/4mW3vyPkzeKgWhbLccZKz/GJ/ZlPLGFWmd6xsM2b0sbpVUOrJsBg==
X-OriginatorOrg: sifive.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e1ef478-9a0f-4fc4-9019-08d855767b95
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB3451.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 10:44:24.3085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SGyQhd8kkVvyQA6w3C3klNQLSJbc9aQ1XjfVeElTIyMkujcF7B5yeGAzQmNYjpjyLOHZxicwsvdmt4J6Ytr50g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1301MB2106
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The PRCI and PLIC controller bindings are in txt format. Here, we convert
them to yaml format.

These patches are tested on commit f4d51dffc6c0 ("Linux 5.9-rc4"). I have
added the log of dt_binding_check for these IP block's on 5.9-rc4 kernel
here [1] in case someone want's to refer it.

[1] https://paste.ubuntu.com/p/VHqqnXdrkJ

Additionally the default log of dt_binding_check on linux-5.9-rc4 without
these patches can be found here [2].

[2] https://paste.ubuntu.com/p/KNGJrJvvdt

Patch History:
============================
V1: Base version.

Sagar Kadam (3):
  dt-bindings: fu540: prci: convert PRCI bindings to json-schema
  dt-bindings: riscv: convert plic bindings to json-schema
  dt-bindings: riscv: convert pwm bindings to json-schema

 .../bindings/clock/sifive/fu540-prci.txt           |  46 ---------
 .../bindings/clock/sifive/fu540-prci.yaml          |  75 +++++++++++++++
 .../interrupt-controller/sifive,plic-1.0.0.txt     |  58 -----------
 .../interrupt-controller/sifive,plic-1.0.0.yaml    | 107 +++++++++++++++++++++
 .../devicetree/bindings/pwm/pwm-sifive.txt         |  33 -------
 .../devicetree/bindings/pwm/pwm-sifive.yaml        |  72 ++++++++++++++
 6 files changed, 254 insertions(+), 137 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/sifive/fu540-prci.txt
 create mode 100644 Documentation/devicetree/bindings/clock/sifive/fu540-prci.yaml
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
 delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-sifive.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sifive.yaml

-- 
2.7.4

