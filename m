Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26198439E1B
	for <lists+linux-pwm@lfdr.de>; Mon, 25 Oct 2021 20:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234182AbhJYSIs (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 25 Oct 2021 14:08:48 -0400
Received: from mail-eopbgr30075.outbound.protection.outlook.com ([40.107.3.75]:3140
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231760AbhJYSIm (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 25 Oct 2021 14:08:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MJB/spn90/bcaED957bXPn//sm0gcxEdJTouTBz/oyyJyFlgO6oDtb74TaP8EhNSafr3DoNcZcbC59Gco1Vf37WQT0b9g5wJWiRL1MrIgJzLdl3ikaRyoK/Bf6Hy0c4t/UFkWxfLIiq2nhN0q8GrsCaBm5l0cvKQbr7GReGDeFH5NY4zhSxDHBVbUPyNgAmkqtNmyaAUYt8b9O1q3TOxoSg/v5/wuZJ9MpncXHKxWavL9Y06fLYAeD2tthSdp9YFOLKQ+F1s0ht3kpYEznJcCHS9LZ1CYpQac3mAzO+m5ZqnmwzuRMZHH5Tv2d1si00gNE6XBD3wY6quS7RSEjzvoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FT7nABvr0awVz/BPsNd5qvSkD7NT1Hd45qJXEzS7Vug=;
 b=oK3NmhalEWrzzAqNFs778dSNVx4pgENLk73WX1N5xrYLbvCx/BEWd2n4YR05HILmjxULpHiaWsBMELXg39RDgiUwDgoMrVDMIWN+X5QzI/nZwy4SCyj2JDz9n1kiJx6SrY6PdymnVa1GSX3dHZlHxDARzqMISiQwlMw9E9Ar1XSGyHIq7QYGt8OU7RR7m7Z1sekiv9ZtywKUVajqrXHExWgOLC1nCYx2O/Ey0/XA/vdlcNA6ERHPWt5GrrA9PjXSy7ubnmi88bdHXTL420xspJmqU21FWzdeQB4ik8ACKzEP3zlpwCGQK4nXmPDOqryJ0R1fNOcY9kKbnX3ZIiEZbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FT7nABvr0awVz/BPsNd5qvSkD7NT1Hd45qJXEzS7Vug=;
 b=aGSRbMGr619LKj1qLk0gEDiL2zO52px7cmNQAtbDHoRkP8cIBj/MBEmGngi62ZqQonR9rjNWNQdK1UzFj/bfO/iac23hpAg9DzunW590Y92PzrE+uCPOW+Wy+WmkrbzrIVGx0A62ViAbW0y8ieBtAytcfi/IxXVbsZou7zWGRF8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB6PR0302MB2823.eurprd03.prod.outlook.com (2603:10a6:4:af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Mon, 25 Oct
 2021 18:06:18 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::a9aa:f363:66e:fadf]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::a9aa:f363:66e:fadf%6]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 18:06:17 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Alvaro Gamez <alvaro.gamez@hazent.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        michal.simek@xilinx.com, linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Sean Anderson <sean.anderson@seco.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v9 1/3] microblaze: timer: Remove unused properties
Date:   Mon, 25 Oct 2021 14:06:03 -0400
Message-Id: <20211025180605.252476-1-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0036.namprd03.prod.outlook.com
 (2603:10b6:208:32d::11) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
Received: from plantagenet.inhand.com (50.195.82.171) by BLAPR03CA0036.namprd03.prod.outlook.com (2603:10b6:208:32d::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend Transport; Mon, 25 Oct 2021 18:06:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf6fb383-6396-4e45-7f5e-08d997e2243f
X-MS-TrafficTypeDiagnostic: DB6PR0302MB2823:
X-Microsoft-Antispam-PRVS: <DB6PR0302MB2823F341752BA472178B42FF96839@DB6PR0302MB2823.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /jwo+1wR1pdW9WloeHgoeUlc/qF4k56ov/Km52xpR6sXpsMU8bE95fuwnUaLoK6lb+OrysUPFGanigaTR/l/lnJpkb3G713z+5ySVa5cAzYbtqpIjPIRLvX1FiAIMlng/TLbovrh3hm42sxKANfKC2a6+nITfarvqfUlMS7Du+uOKrzz5tvPWpy0hw8ZmugCBOjnZlhGob6i9ecJK24bPA8FUmgrqj6GUBztajDgbT2J6JswIFH3A4MG/ZFN0sNmkDI1vMip0noyKrsf8EgxF17U+gVckLfJkihf9b9YNhuNR5d7E441H7QZkF/h8E+TbLDcGgmq5QbMxjpC/Ynt5Uz41xxGyQ/eKOWFZdwNnMHM8Emegrln/o8UaNkGWaJI1CDiuwdKwULhCxpnMpf5h2J1ECKfperjzso66MGV1md0l1PpIw54maQALZ4FmqFwSUJ+Gt7+TnQZmg2ftm1O0JfZ7wOAWlWWT2NZJy7Z0P+dmEMMmhnRnMOHU4eXuu56FGf0E9GRtqD9tQk112KCYCM/3gm6khjDf1I7dWQPA6Sdzh4koHJoPYvnMKJXDCx4BxrHjCmLwbDfZrZsgI+k3suHGUsedeQLaOkm9EmPRtKc1SWD5s1dYkA5PT/dSO9cLLLVJefT5bCsGc6XL1AMEneQBLtPPH+HwL1MZqGybT7ZtV/3bPW5K0QaV5M9P31/rLuJirlu/jGHHmkJRrlxAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(6486002)(6666004)(54906003)(4744005)(7416002)(2616005)(44832011)(956004)(5660300002)(83380400001)(508600001)(2906002)(6916009)(6506007)(316002)(1076003)(36756003)(66476007)(8936002)(66556008)(38350700002)(186003)(38100700002)(6512007)(66946007)(86362001)(52116002)(8676002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gRpjntArHjgMWpwJMCLJF+M8TTkLb8VJr/hrstEt0guZlksrKMwLgFqTVk02?=
 =?us-ascii?Q?ACK6P1a3jTlcM/FBLoHSvU/DEP4H5iAoaDks8erlOXrcH7/wBKWAYuSBYz7R?=
 =?us-ascii?Q?+UXVWFlpCs7JqLNQaFI7S0IJGBRh+5TKPJdby1IXpA4CtiRnbmHYObLYfuY1?=
 =?us-ascii?Q?OhrKvKQCUkEYrX3jHhS0mZdp6qkZze64F+ESvVi+IrFaluPCiCTAo+nMIdsx?=
 =?us-ascii?Q?s+K5AFG4Ix4jb66njvEjSxGWIcH7M+icSvee2joS+P6w3aCZnw4s/nYk0OUI?=
 =?us-ascii?Q?iAkGSidelb3YSbcI8c4UM3drkBTNYhV+/kmYpASGmeXX3YmfaPtoHtBSiWHD?=
 =?us-ascii?Q?PjU8hE6+OMcmyz8Ecv1hq1gbrPqj4VSwxujBcKqjaBC1sx3OEHb4sDbNIerF?=
 =?us-ascii?Q?g7++/gPR9Ww7skRRdmiolpNzwSTHtMyurGnl9iwU9uAb9OFzJXZT6wFuGYQl?=
 =?us-ascii?Q?l4MfQBHf9z7KATboEpw1OYSrekk7/aisccFuBRNRBVJJA4NbhR9IpBaFRuDC?=
 =?us-ascii?Q?64SUXSs/SrSHfGC9vaC6TfYxHv1ErjmPGQo4WpzeFq/S/k6oPD1xq2CAJYg5?=
 =?us-ascii?Q?7b+lDVdIcbVbedahFiOSMGyBEO3eLimm4BRyK2ob21qMSSttOwi/2T2/S3Sf?=
 =?us-ascii?Q?JwRLtvD2hmkQZkBOAWGo4zsTvysa/tIPDNUwbxOyjGV8taRfAB9lEHE5Qmmc?=
 =?us-ascii?Q?hP6tt6lfVAAAfObGS9eQgITdLtwAjc6AFctVLli3fz38l5Bvz/j99L8z/pNA?=
 =?us-ascii?Q?DCFOnCWdDvn94uDLXamsijjpihTwr0ozav8m4Cr9kXIb1aWj4TbJ6AqdJlky?=
 =?us-ascii?Q?CJHC4+CCJhyKpCHelSAAHWVHz3mVw/ol900A2U5nZFNq1lGSdWpjqhxSBui6?=
 =?us-ascii?Q?FBQjlVwCTPu5OeLbhOGz3OlbaCUHwHoQzSc2z+Yy/zTL7TC8I24gD4Gq4HTM?=
 =?us-ascii?Q?P3DmtlEfULZvthccB8vWYPoJGdgS+wBTncIfPCtOOUs6drByQh2L60GhUy/5?=
 =?us-ascii?Q?V3SI852dBJXjPEvkFxvj8Hit9/bgH1enYVb6f/qsZU5UBemt9iWI0RAbkTiw?=
 =?us-ascii?Q?tjK570ZLxw3716ErXfu3xG6qNhiDESDo74pbadMcREuuGUyc5CVwP33ivciI?=
 =?us-ascii?Q?o5GO4WEKZfBX3coOf8bosB6PnIIWKhfn3B8zvThGBuyPXmwBAYNjgksN07fi?=
 =?us-ascii?Q?8XIEWtjfDBfG26jN5jSMit5aoIsp0Dvr+52LjtlGO8QPWVEP6zSWtuKoFuhI?=
 =?us-ascii?Q?6V3U6RwIGjiBg9nfG4y0StHyGQxPZuHS8LZwx2K01unz/kWF4NT51kGcncuU?=
 =?us-ascii?Q?5LxFtfUtVuyYkBTBGwibIK3DGDoCm/3E7VRhl546gJvBFUD/WWgyeRDd/Pyv?=
 =?us-ascii?Q?2+VDHDUtyvn7xqa+FGqOS/usQHHbt+/75FCtTVxZTgJmt9bEZ+E3bVy7Msdq?=
 =?us-ascii?Q?lBJGlcIameGqHDI7Z8RsmYDDQIeXu/iOSTnNoV1SnSzTqKcaOe9tOcXybOli?=
 =?us-ascii?Q?719S0dI13Ev97glFpoWxsZDfFhqfcNYnERsyS5NPbJq9GAEBIwVzrRas41lX?=
 =?us-ascii?Q?B8KB8SJi61lQd1Kd8wUN/XIpusoXaHwR0UsYX6PrAqeULfUpAQtOeZ8xSLcX?=
 =?us-ascii?Q?Q2DwTHBzkq1i50TVY1hJcFQ=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf6fb383-6396-4e45-7f5e-08d997e2243f
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 18:06:17.8298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7P/rhBBEdvvNTMjOrZocHpNAmhSfaES9FAqE1SxxEVBO28zi/jSxiI7EFOPEtNGVBS9EZHgfOuChNv2k6LLopw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0302MB2823
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

