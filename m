Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D40D144ECE8
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Nov 2021 19:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235373AbhKLS6X (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 12 Nov 2021 13:58:23 -0500
Received: from mail-db8eur05on2086.outbound.protection.outlook.com ([40.107.20.86]:5344
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230137AbhKLS6X (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 12 Nov 2021 13:58:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m1TovfkA2fv3qa+UQQ4ExCLSuJ+S5WjsVsKf0HS9bt889TgpXFyJhte388IiPuUjICP4AV1voNQKKPULF1gyx58uMkRa9lBHZGNoLOGX82oO2POTooKRWuvKcHYTREaMTLEvjkuIn90ZVKl9JO8uJ/JXwSgE60blXPIbnCgIpz3VofHOYPLfwIXXWSYW7KZocG50aIPAay8cKU38nqVMxpJiVNm0BdQ2bkSBTRTZ0hJ910HSewMdqU6+eWiRUqL6IDqU0s/9JUPoXWhITjviUn5Fx8RXCdM8NjDTqNgCxNy7DMRoK5MRMY+GvgYc3SuJbCbncPkzgeWum67QfRjmuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FT7nABvr0awVz/BPsNd5qvSkD7NT1Hd45qJXEzS7Vug=;
 b=IMEpRRq9XYw8wTguIzPxzwE52CU/e4gxt7dFhtw+wCeH0WhS7RR36lttYzbn7nx2287iJ63vFqHgyFalLxqt/CdAgH7Govmv3U8xvnP14x15oZ62o0E4qLP6hfdqD8E7kI8Y9Q+IVyu3oITs9O5S+KhrNpy6DpiSNrLy94vQPKd5cjsWDkP1UftOhrqkiool7+6iUTUH6bt7qLVSJO1QQgxnYLSE2slFnILqzY5pvE5v9rd2byo6/tO0caQKUpd095pWxC8DO4K6EfEpLQbSl+ZXMmcqlwrgAgpik4Q3g6Gp4cOzrv/fqXVilkLnN2quX87a8+TXy0m0KQ5HQ3psBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FT7nABvr0awVz/BPsNd5qvSkD7NT1Hd45qJXEzS7Vug=;
 b=y4goEzCbovKVlBqzmG9J0i+CrSJaqbug/1rXurx+J/gMKT3picWzmF4ukxC6QZwQ8iZl6cbDklz0w2k1XHJddfsqXQI0sguTLEtt041uVw2LGEVbL8moRl/lVPA22Z8faofiRJDXo6hKw7Ve5TImFuq3f+EVrFWGWdYmxO6EXhg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB8PR03MB6201.eurprd03.prod.outlook.com (2603:10a6:10:13f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Fri, 12 Nov
 2021 18:55:29 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::a9aa:f363:66e:fadf]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::a9aa:f363:66e:fadf%6]) with mapi id 15.20.4669.015; Fri, 12 Nov 2021
 18:55:28 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        linux-kernel@vger.kernel.org, michal.simek@xilinx.com,
        Sean Anderson <sean.anderson@seco.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v10 1/3] microblaze: timer: Remove unused properties
Date:   Fri, 12 Nov 2021 13:55:02 -0500
Message-Id: <20211112185504.1921780-1-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0210.namprd13.prod.outlook.com
 (2603:10b6:208:2be::35) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
Received: from plantagenet.inhand.com (50.195.82.171) by BL1PR13CA0210.namprd13.prod.outlook.com (2603:10b6:208:2be::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.14 via Frontend Transport; Fri, 12 Nov 2021 18:55:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f8ae65e-39a9-4aa7-c50c-08d9a60dfe90
X-MS-TrafficTypeDiagnostic: DB8PR03MB6201:
X-Microsoft-Antispam-PRVS: <DB8PR03MB6201A66A8CA0C98F6BB1BC6C96959@DB8PR03MB6201.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k52JpBb4q156JdFbmqsOna3qegtNsELpYidTW01a4mdG68l1Ny+xkh9BRvvZrgj/28aIk/oMtCdiMoxRd5MrbP6Tl1HV+9wPyc4nsROS4dMqtJcUB38o2GkOXQ3fycBWWkQZFbd4NnNMy4FOUVGkJbIFe0B8ngT6fmhfZaeDVuyGPza9bli2h+FK90Qb6QFDT00ROeJCVFYZxvUCfAzMIumd8AgDgDoDOTd+5jQKh7sqzKZ7mgbo8KletQL+UOJM55rNOMUbFHCk+OoB7CNgA1cgF7RoAsWqI98io7WpEqC2LsTt9gpOG2pZBR/8jSgZajtisvVs9r6adHlkNRPCiiniCgDinBYk9zhJrnBGvnxdToLWVHCcv8ioK6RvgvSxxGlps38HpPQFyiAwlpv3SxAy3Byzb++I/QulB7/evifAdwsv3W3RXjzHwg+q01rM9O09Q5M4GHw6fmfmJ0bqH52i43A8oNu5mH/2ZOtKteruOaTJtnAXS3eCHRMvnTWQTOYE8x+UdcLWh3JnYGAR4h1nAqTAHdehBdv8W1Bu0oQNHcrAkUHRo95Vpa3cGjWP0Ll65obg7LL+4NaM6buzz55yoFRvACEy0Yc3/hd5QC1T2mFZz4y81uVpsOQMBpyMfdbFb97Q4aRIorwCG828gbq2s+AqWxDhwLP0E6w2ycdaa1K0ovJ7rOhmjhCXxi7W/PO7qCsNF4AIDRZz9/vX3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(66476007)(66556008)(7416002)(86362001)(186003)(1076003)(83380400001)(26005)(5660300002)(316002)(508600001)(66946007)(54906003)(52116002)(38100700002)(8676002)(4326008)(38350700002)(6506007)(956004)(2616005)(6916009)(6486002)(6666004)(4744005)(36756003)(44832011)(6512007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ckX0fPAEWQMaIV3B8v7h+QGkMv4l1YdqmBhNXB9gxjtuTVVwFb9vAlg8UaNB?=
 =?us-ascii?Q?5jNhc9B/UlYpqC0xuXil6Sc5yVTWLE/1CoEWRtx8V6WwIJLCk/Cxxyrc8gWs?=
 =?us-ascii?Q?Bzfe+YFkPzXnKRJ5nanNxiXdhUAbYfOODcgqzCJrZoH+4YOb72ZKjcqY0Tfe?=
 =?us-ascii?Q?PqIU9CJZIvpXL51hex4cJcdyeqGox1binrULuIMc9cu1db7rufgLhMExDOCv?=
 =?us-ascii?Q?ns3yvlDFCaGAffz05L2wX8oYPuX95nv32QiPZHyGehmFCMjSDaaqaFEW8BQ5?=
 =?us-ascii?Q?8OQ9bN03UBiU2gw0wcQIFd9KkEh4IFWSJqgzCmXx1jHbvtde7HKLmSaXNzO4?=
 =?us-ascii?Q?Lr6puBAj+SEug9TgHPcpkthukBOPWNO1uQha/S1qc4TG36EpfoRC8JCWCOew?=
 =?us-ascii?Q?MInmgLtQ0EmjwJRF6HUDYnDHejglmg3S4sZDOXLTljLUx118+1f6XnZ7ZGPP?=
 =?us-ascii?Q?NVBgZDWasSPbliO66QWvGBulgxgxXz5WkD1DfJPGlqOjF/JnyczeodFhdmtI?=
 =?us-ascii?Q?Kn/2YB4zkGuZpAMZJR1x4Dt2BH5g5xaYLDq/4ejSTb3KIJGSm0F5SPmRtdjd?=
 =?us-ascii?Q?ZsXq94uQ4tXFZXqZwmi/JCZqwhrQq74ULwlL18GMFFytaD+JjFIS6jflf8Rl?=
 =?us-ascii?Q?AS32BgiE9COH8oC6k2Od8Z/pe+7K9hpBgTAWkzkFma0AiNni4U9tNXS97z5P?=
 =?us-ascii?Q?IdNi3GXZDYQw3Hu3TIN7BH6dIA1ef9Wef7pXXROl1MuXWwqZbGUIr6l833qp?=
 =?us-ascii?Q?IEe/QJkbUksr6NRUrfk0MUeeg1eyEe11EJ+Syu/GEOosg2bSIKvevao14LZJ?=
 =?us-ascii?Q?Z0CsbccP8sb/f72B1Fg59r6McztFrKYXCiR223c7CZlV0GGsI2i2ePJ2s7eO?=
 =?us-ascii?Q?Zrlp7/XK6L23tCj70SN6/Q230poOjtjfUMNdEiIENwsoZDLeoFkZHpJwPABS?=
 =?us-ascii?Q?K7gq1BzV7JYxdi6QcseR3Lwf2zkIcLwQJ+48U+NddfhbPn6x+ItXmWYHkasC?=
 =?us-ascii?Q?CxcXPMoDLn2VFl811iU4rkC0wQyveHzIBc8vRZ1wqIT1Bedb4ntz7/e0h08e?=
 =?us-ascii?Q?0UmNb2jKnr+Jkdi7jm52rzWFfdKP/kk+cFThyGXV9k4V7rCmH0aLL0LiZr96?=
 =?us-ascii?Q?oi3GjVs7CtXPuUzdrxmkozvZK8YtFh5VMhb8nS0Q+zARMAlqg3Ck/P8meZgg?=
 =?us-ascii?Q?Ig6DHl4KQtlln5qgi2PZ/XPRxSpVJJQSqWmnlceWZzL9Xf1Cnht8/Q85JGSh?=
 =?us-ascii?Q?PSI4P95PKB6+sjDtGtnpmN/8KY5cz0u7qdo+puIUbsDeXr3zxc/9GiGUG8QC?=
 =?us-ascii?Q?PNz/LgRjKt7ZSNEYx6CmmcSVeZ1Wb00u061sRuYs/4IIHRW1BJLdiJMQqWqt?=
 =?us-ascii?Q?oo3N4VmfMeKZJnXam3hQRU2YXTCcO7QzpoLRdU/l94iRLYiGIXbpU4RRnyUb?=
 =?us-ascii?Q?v+esbx5FEx4eYCagGslsrOhUJ+kVVZxFDZTQ860Oc8o1Nn+OIZh7qTu3bwPs?=
 =?us-ascii?Q?Y/MXOKE+Dtw+0Rs/9SnlrOVNnhXixRqApfw5yhbhQQr3/mWWSKOepyZRgjlo?=
 =?us-ascii?Q?VdcT9kLtaoZcRtcgZcF0RSWImAMgMyKFwg/jsS3lzXBCpeEUaHlbGm26WJC8?=
 =?us-ascii?Q?eE53x0mL1xwHGEoCRVfyrEE=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f8ae65e-39a9-4aa7-c50c-08d9a60dfe90
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2021 18:55:28.8381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NYhQ3+CYOs/cFxJFQoQJNSe9h/OtEeqadNYpcEckiprFlBcoBGfXv6gy6Hjtz2zsrjziSBE3TfNpDFddwbAmCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR03MB6201
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This removes properties not used by either the PWM or timer drivers.
This lets us set additionalProperties: false.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
Acked-by: Michal Simek <michal.simek@xilinx.com>
---

(no changes since v8)

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

