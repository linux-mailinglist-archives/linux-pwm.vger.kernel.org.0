Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F295742FB8E
	for <lists+linux-pwm@lfdr.de>; Fri, 15 Oct 2021 21:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238260AbhJOTC6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 15 Oct 2021 15:02:58 -0400
Received: from mail-eopbgr80075.outbound.protection.outlook.com ([40.107.8.75]:43077
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238178AbhJOTC5 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 15 Oct 2021 15:02:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZXwZbIo/7oNSHvh8fEI3bxwzF0YV3LmfyIHtUIhlXI0CMUqyTxHolClEKei8ZVZ3ikA32ta+E0dEARcOqscaO3hyrtveJteAf4QKMQycsqMi7pFSShdbGk4w6t1frWKuh9YRpzl/0HIzhjru/c3h9jioU6otHOA4yK2284ARwxtwzLd+km32/YrIEa72/82RrYildrONNKxAbvaLWtbVnMlxw8dXZe4SlxrnTdU7kb5LmlopfURTVDLwnJ3r1iIplLRvkJ6mjj/00pahO0K2x9U4SSk3esmd1VHQem4Vm55F4ztDbkhy5EGjpNV3V+gIU8UtNj4MGZNlbJ9wT+BxeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NRtfFM0mmHjLk5L4BXywSmi2PecSyjTFE6SREgSvDyQ=;
 b=UuT6qLgqBMtg175nbfdSPFhdAzz3MuvwCaCXEvGu9ZKR8NPntKAlswREsoALRxVU0s7xl9MNQ9xCCIYGT5co3n0LHmAPVhiE7CR5fQmGHlswXVmf94J8WYN/MXhFL+hUJsXo5RafoqWTWNlqPzzn3fX0Ljb0/WNHT5uNuAvAXFpIgZmkZmAAoevMiirtPwUhR3qgi/tcRy7cSMCmoCXHjTBjr+PttghmVEGRY1ASZcRG6ahsX8eLsKv32R+TzHW1ilxv0RQvBYVw92ecZ7Ie6aZfMg3pjJs2gz52L8O/wpcY9lgc6xLK7YskaMK53HPbtJmHOH9ceXnmjL2jLWiv1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NRtfFM0mmHjLk5L4BXywSmi2PecSyjTFE6SREgSvDyQ=;
 b=OFypcXVUcs8iC7pmztpipg8F5vzQIgKAsCwjL2Cf9u/h9/67ViTAFTC231WYBjSpKBQ5lf/DLclaUyU5f3nUTEd6qA51uaVPyYwAF0SV4ecE6UNFtfRyut4ReaWEGttx16WBLS0/rZkrrg+O3iwTLuhk3OXFE0KEmZn/5kMI2/k=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DBBPR03MB6905.eurprd03.prod.outlook.com (2603:10a6:10:205::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Fri, 15 Oct
 2021 19:00:48 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::a9aa:f363:66e:fadf]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::a9aa:f363:66e:fadf%6]) with mapi id 15.20.4608.017; Fri, 15 Oct 2021
 19:00:48 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, michal.simek@xilinx.com,
        linux-arm-kernel@lists.infradead.org,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        linux-kernel@vger.kernel.org,
        Sean Anderson <sean.anderson@seco.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v8 1/3] microblaze: timer: Remove unused properties
Date:   Fri, 15 Oct 2021 15:00:23 -0400
Message-Id: <20211015190025.409426-1-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0096.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::11) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
Received: from plantagenet.inhand.com (50.195.82.171) by BL1PR13CA0096.namprd13.prod.outlook.com (2603:10b6:208:2b9::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.8 via Frontend Transport; Fri, 15 Oct 2021 19:00:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b9b4b02-9b81-44de-90cb-08d9900e199f
X-MS-TrafficTypeDiagnostic: DBBPR03MB6905:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR03MB690565F0AEECE670466B306A96B99@DBBPR03MB6905.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LoOW42uv2UEdiir6vsuuo/t/bC895Cc0A6nDSI4/JQHBS+dN+IwpNr7aUTOrVn3mMQbkzbnX/VvAHAhNjckCbSXgZciTxGRClj87xmYmf2bDWQ68VbzqWLsOT/Txd1+5qRDtSXLx5hEncy/aHDim+RdKqkpsdMGm0iGd0ZxjagLFLVpAKLcEZPr/5y2Pnoq6KIeGwpH3OhYQSQxKZr7SGBmRGbgRYSRV+4Zjsk1NvQh6QcAa1WcChprz766m8ZH2DYQCZp30vNhubGfh4CQic0x8rQTmKPGMgFs5VOP7l10WeNjpA8JW3Rbn5QIyCgJ6pfEfUO04SRxfDaCYFcQBGJxLoWGYSe5AWcj891m5ZsI8MGjagXLKFsRxoVTdKDjLrUbF+njv7qabPDt3+c2uDPj+nIYu8SsMLJYUUcTGqVuz/MW2oEmFEAU9CRRv3D4zcFeZyUHPueOSHJNazMIG85tgrTnJJiq0/P17924sHaaZrcbZE68fbdnl3G0A8ipW2aknl1OSNbsYK1F3qdHG2sEAv4uj69Hfs+3A2qLdKTNhLzDlU5d4HfFtxndAgnNpUQhdyDub+LN7pfBUtZaVy3iX72IufxDmL+1oR1Y1p3Jhek9/TlFJDvURtVwCpuK9KCrr/WUoZuXiNPGXPjvNiaCDOOnSaN7ZdtDFa1uaEwsocHFRiOoxx4xqmNV1N2h44JfixvWWHrn3N25UcNP6yQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(956004)(6916009)(6506007)(54906003)(508600001)(1076003)(6666004)(316002)(26005)(44832011)(4326008)(2616005)(66946007)(83380400001)(7416002)(86362001)(8936002)(52116002)(6512007)(186003)(8676002)(66476007)(66556008)(2906002)(38100700002)(38350700002)(6486002)(5660300002)(4744005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cvE3VEBNvB6PfcF9L3RMRKJK48px3RmQaR4C9D2p/b8MHiu2IQoEjcvGgv1K?=
 =?us-ascii?Q?Vr8FAigxdydNw++0qD2TbIbKYVcCWnnI3tf1/rCirFqswgKo8NRVHBGVKHLx?=
 =?us-ascii?Q?WhYl3LBSknonTe74xLmrFXmfV4MT5BHGyZ9OnEUjroycURqDrmQjaL6PYrBm?=
 =?us-ascii?Q?3Va9TK1fFm/0oQdJwbjn9eiYkMVXVNqp4X9ercLWtgDequBYpRhsS8zEOTci?=
 =?us-ascii?Q?tPDubVvMQ7BQepD8MIw66Bxc+OJ5mp7QdYM4gY+jG571mm5Kvzb0rYZ2pkhH?=
 =?us-ascii?Q?CtgumctLmLI+g6NX/JnPsHkkbcqX8c6qxAOsc6QVuXSit6Sy3tyZpWi8buDl?=
 =?us-ascii?Q?Mvzi3MkleYPsmfYufUNEDjvUXBruQtKBBezKNup85PqDfFIz58qPAUiemu2o?=
 =?us-ascii?Q?R0YZPr4Iw5sd3bt14KJ6m+yiVObeFCnNfJi++Aqk7ipZqbK+eA+ynskyMlQu?=
 =?us-ascii?Q?IV2BiW+oLWMoZs5fn79EA38GAkJd5mNlKjgsrnpYcV5L1wRcVxeWSJ5P7Jvv?=
 =?us-ascii?Q?YhevWpaSlYzk665gDQkEydI5ilmZ/Q5i50I/qzRi7B2f/zRftO3u76feieaV?=
 =?us-ascii?Q?FPo9fa4wSfHvKeIAtRkNsGtDNHh+WBxeOl8M0iGqraIrLGKCvvgEqlLBL+pe?=
 =?us-ascii?Q?khXfpqKorOakJATXjxp4l/znsnLWi1K+zEjTRBjc2OGZsDRRz/qOgwjui/eO?=
 =?us-ascii?Q?JHBRyu0EhUsCDr68Aqppw6pd/xS0JglJ/RbSTTcMMGMDXhPvgpZuTYaYLQBW?=
 =?us-ascii?Q?7ukl8cjiOx8YUKy/AjA7t9h2nUkEIhlCIZObS2IJ5sShAg5QlRst7cPjCCbq?=
 =?us-ascii?Q?XdohIbggHnnLQsDkj1wq1NgcW6L/bYyq1xtQZFc2tyW1+saMDq34ZqdWGb4E?=
 =?us-ascii?Q?4kyFcZebyvRuyAXmeUHZ1c1TeN8kwYKP6Uf9lCmx3XzlcyZW5UjPzruJEEZz?=
 =?us-ascii?Q?iIjmWOXXuSCtOkup6Sn1qBNLJoQJkvXReUKsv8tYkZcwwIj8PAmceM6Ivzk1?=
 =?us-ascii?Q?Jr/R/VDrCQa72/xY5J7WbI+NZU4rFrwGbTeR7QJEnSpWmcv4aN2uDTGvoD/0?=
 =?us-ascii?Q?PkVeeiavCrHYTsjiBsWxj/Bpnd7UXZFTL3N0xLBn9emUCi8ZH6gYE/LaNKQl?=
 =?us-ascii?Q?zlKxZJoedYm7yu9pgyh/wiMHMqX9LOVsk58yK/mccg5LdfRNhYXA/hQniIQU?=
 =?us-ascii?Q?VeDsrTzavt+7y6UAIht1H6mQy/TjyePvvG43l0/ddR/ZfiwH6l6TYSnK9JIa?=
 =?us-ascii?Q?NgfJRyYi3OjSPV6ze4LBwjtthRJyMB9p8Lm7c/AlNS9yAZt75oQuNAjMCCo9?=
 =?us-ascii?Q?tyrXnLAX1zlzCJ5y8iX2Nk1u?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b9b4b02-9b81-44de-90cb-08d9900e199f
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 19:00:48.5934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WBpjJRHn+lfH1CZpsy0m6zl0cgPqJUXrqex5MkUASqtdjlZjdI+HycDQ2ZfWD2FSPZjr1Z+QqU+QH7N7ctTL4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB6905
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This removes properties not used by either the PWM or timer drivers.
This lets us set additionalProperties: false.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

Changes in v8:
- Remove additional properties from microblaze device tree

 arch/microblaze/boot/dts/system.dts | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/microblaze/boot/dts/system.dts b/arch/microblaze/boot/dts/system.dts
index b7ee1056779e..22252451ec09 100644
--- a/arch/microblaze/boot/dts/system.dts
+++ b/arch/microblaze/boot/dts/system.dts
@@ -347,12 +347,7 @@ xps_timer_1: timer@83c00000 {
 			interrupts = < 3 2 >;
 			reg = < 0x83c00000 0x10000 >;
 			xlnx,count-width = <0x20>;
-			xlnx,family = "virtex5";
-			xlnx,gen0-assert = <0x1>;
-			xlnx,gen1-assert = <0x1>;
 			xlnx,one-timer-only = <0x0>;
-			xlnx,trig0-assert = <0x1>;
-			xlnx,trig1-assert = <0x1>;
 		} ;
 	} ;
 }  ;
-- 
2.25.1

