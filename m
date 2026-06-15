Return-Path: <linux-pwm+bounces-9295-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ohNyGDo0MGqHPwUAu9opvQ
	(envelope-from <linux-pwm+bounces-9295-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Jun 2026 19:19:54 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC5D688CAE
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Jun 2026 19:19:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=starfivetech.com (policy=quarantine);
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9295-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9295-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B284310A53D
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Jun 2026 16:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69AF73C8192;
	Mon, 15 Jun 2026 16:31:50 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2121.outbound.protection.partner.outlook.cn [139.219.17.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBAE409E14;
	Mon, 15 Jun 2026 16:31:44 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781541110; cv=fail; b=bbN2tntTLUChHogsSYQKekYO5f28vP4Vz7W2O5+nDXVhPxFKSI8yDOIIS7nAQNe/1RYQMq7PyWG5YHkmZPWfwkcIVajquXbUtV1Oz+/OmH7UGhk8akQ4s7c4x8NdHpypLl4UxkBTF4acyiALI9S2S3w5HtAinZIZAInTGWpWWyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781541110; c=relaxed/simple;
	bh=OKeWpuhtsXOk7ZyDHUyce0J0eqM8c0PmGJGvauYO/SU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=soEaPf5VuKs2PBqOXriq0S3d7r+CgxhZ9aAV5zrHhB5Yg551q90Rw8wlGg00CKu1duuyGo1F7Gaqa6rm0P/TYL5/AbO/j1I/GjCbXe0vCK+sHtv249cdqqCCvGrM4whn9aJ41Ytdn6+x1o563eZpd5BSwp3pJLKU7QbeA1rY2aE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.121
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PLX+ePVpTLZEEa8W2y3UdTNfHgOFmBUVGRqOJf5rlr/AmDq4LZNFTMlKemmIshbGFnFFQArIZ5ozYwZiE0EsmxTY+vC30wHNLqPzFfPYPX8H/tmeLW455vFmN3EkZtd4gca9rxQ6lxEaQyLSnwEd2BJM4pmo+xRC7INv+oPAXnY8VcYcpvQCcCX/nrXQtnF3vaZ4t/TnsPtgQMKdGiDTgGWcWikLTWGBHzuTFwhB6ieGFFtwkV2ASRELozsx1aqRJHAI5UrYlp2ayAG/uONStLZufZ7KGjg1JmEL2X1ZJ0Ft52gc9sDI8ujatey+BwmBjV+JB1Mwen6DGdqX9mMByw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FE/5cMUL0MkZSoxuMgE3rR9Njrk7sgGP6ob4yyxWhmU=;
 b=DMGJl/CHA8drJbUo+P/nOf+sW6BQqqExv5XZWlqKPRCLdLcD3Xu8eluHqjb35KpkP6q5U901tZGszGg11Z9Qg6QUcc/X4y2THARX0tc0mPvdMi35/VU+2IpaOMyX1hkGaa+/+t53mLYrzKwcPTQYzW5evHv4WLzVGEL0q/PY95L8dbyUEUT8/sEB2p4Nx6fymnbkXTDDzdW+6uy1E4VKN2qqNnjFXq1kUVysje3omIv7g6p2i2G5WWm4yTc8+hr0NXbFxmv1bp0kmD9Rg/d1FDgibjCSj5UiZ1HAin120Ryd3r62bYXwBDvRceEXB1S9tFbKiDNhc8ygEi/HGfYbmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1321.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:6::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 15:58:08 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::4386:5cc4:3bc4:4795]) by
 ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn ([fe80::4386:5cc4:3bc4:4795%3])
 with mapi id 15.21.0113.015; Mon, 15 Jun 2026 15:58:08 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor@kernel.org>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Hal Feng <hal.feng@starfivetech.com>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v19 2/3] riscv: dts: starfive: Correct pwm nodes
Date: Mon, 15 Jun 2026 23:57:58 +0800
Message-ID: <20260615155759.129210-3-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20260615155759.129210-1-hal.feng@starfivetech.com>
References: <20260615155759.129210-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0065.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::32) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1321:EE_
X-MS-Office365-Filtering-Correlation-Id: ccacaeac-0172-4ee8-452e-08decaf6e503
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|23010399003|38350700014|22082099003|18002099003|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info:
	GPcPjLiXZ4Q9qe3cIkGKi6HUU3kbkSFYqhdV29QOnKrLbOu/xXq4kMUVlPkMBhZLNCeI+frzR3yC9uov3vUy+aWaYCfTQj0vZgSHKloFFNxI92YVfWbjCDKDcPI9syziHE3hsKevaU5Dc/gcxMYywczmx399FcXvdeMCJ97cBHTixqbX/aI+UOWjNToGZ2iUgh4jn0OtayRJ8fYM6mad14aRvpD4aOSrgmjjC9SsY5MCZBfwxfYabegesp2kUH/22Sg45SECfqSCT/LKBiNemSxQShk+0No8XSL6o/coYDYCQ5rQH/Ar7OdEZ+DFaE6J1cJFpJDk7LVm5lzP9MUs/XAgTHKXtiL+TaEJQ7bKfjM8K6t7HdbxH5UL0WmdNHaNjLJw9g6EsrZOCbQiwdtYDLLatoE5QxgjBFyLQu0g50maj81RMECUyrZASdzw8QbpISy+A63KnP3fedWLScfXIV7QHCfT6db04aE9+FJWwjtRylqacmNt3wp3MOkbeliblOS0TzNbR6MKrFL140bk8bXJ7uOGu/p8T7TBzs0VmsK/mwbhNF4E2UBYvHnwZwK8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(23010399003)(38350700014)(22082099003)(18002099003)(3023799007)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bD/Kgnphek94JGmDh4e6EgG1j9KIRFWwdh7x57/LEFRMbj8eS0raFVPGcvQo?=
 =?us-ascii?Q?HCV2q7Vi+N874Pwaa0dvUtgqEt6x3rdWkg8L9esYgxamINIeODX7qikyyLAZ?=
 =?us-ascii?Q?vycBAF55+RSSt5BthFRR+U/erS4VXLy7Sg9BiQIxJVt30Z0EyUujvdYclBHx?=
 =?us-ascii?Q?ql9AasZpmH9j/TW0RZBqR8X3NJxNvGM6NgppWr7ypaW9ypcBQTH6DGHlxyf1?=
 =?us-ascii?Q?f5XOTTrUvakFX0lKpY962Mh01JVHDJmI1sp9B8xpZ7hBbIUNxkJiQn5DzdNC?=
 =?us-ascii?Q?aFc5ROjgbR1z4sRjSML49pFLp28AY/dSnLN1NGN4mt3IUxL/jmoYDmqvHAVg?=
 =?us-ascii?Q?FoQum218svyoFVzJJgQblqKdzN0SJpVVuMltK/sacWAD2FaKHngWBOGdTJpc?=
 =?us-ascii?Q?ndBDI92mpCTpnenjNkhetS7JNgB6El5ouGPZSgbBMqeiIDUUZWUj+Etq6xaZ?=
 =?us-ascii?Q?NV3IeyT01a4ad7TXJ9A5Bhc5tqG/67RmATqaqNon6Am04JMH080sa5PwajSH?=
 =?us-ascii?Q?lKJh2EqyrrqPJJ7KcKqfn9iRgHsukAyCDvg2T5DB6dgHGJs/XkldpEJru7J3?=
 =?us-ascii?Q?7ckKRhkfOH1FbO6ZZJRrst24ZsXTXhFNM49f//Skgbl76QLHwvDjfZhS+zfM?=
 =?us-ascii?Q?qNnQvXi4TIR59jmbT2qxPilSN09dEAe6wBjApmAiMFhjRke0OP4vcpULZJZ/?=
 =?us-ascii?Q?vOHZebmAWpnpdkSeIn2XHW+b7c33IGhIIdcVBi4IUik3pP11YuXhPLCoUm78?=
 =?us-ascii?Q?qqkYVuMMt+Y3Au301cnh4hUGH5loaYDBXrw1wGrY2Tgoj/jmrOqIogDnDluC?=
 =?us-ascii?Q?3d1jIkuAiXovAcLONqo83b2dH5NgUs4xHHvCJUYWTWzqaKg/TmzoIFlOm0UL?=
 =?us-ascii?Q?5UnHfHINn5Y0hJCPMEDnZNhAAe98mcH6pUdiF6WIlPtSE9asPF+YkoZmfqcX?=
 =?us-ascii?Q?bmhOI3LP5u5EcwIt/Bqpw5mvYW6TQ2XcKlJixHcWiTio++cI9/M01FnjwEI9?=
 =?us-ascii?Q?DRknnglTJ1TnAoPVMlmfyMIEyEHDR9/CE++g1U/zMSCEhoeC9reyzPe7ezlw?=
 =?us-ascii?Q?cbpY6vJIiA9ajaKICoM2e2yiGXg17Pth+JJ/b8rnijBwB8h8vUlezmxRglS1?=
 =?us-ascii?Q?/7TdooAyVPoq47es7DSHnZXwNHB6hh7ATL7mCufaH1zWhyAoVYY7RoJUfCHu?=
 =?us-ascii?Q?6/wEPwj+mYkDMugEyNMwRIDLAmhPKbseg7dbY74ADNbJB9viNQrbLit7xbc/?=
 =?us-ascii?Q?Y5dWCGBn2cMNg1oz2ArvsmGwUGXFCjAUxQzQc95XjZeMqtrU+HIfCdRgJVVU?=
 =?us-ascii?Q?kX74hJoMQfCuDssatXE/dG4c6GmoDpQvec/gZhYieO4dgeuUYmoAVDX20T5K?=
 =?us-ascii?Q?zyNFJn5b4YawOx29caM/jtNHP5IVjLrS7Bn/sJ9oPrq7KuNbqTcvbXd12k5g?=
 =?us-ascii?Q?Wul9vn1elDhSW5z6qRT/Fn8jqe722TLQl3kXkBB9fjj/dQbZ4HOm/XezsHka?=
 =?us-ascii?Q?5vTy35jzvNBR1TiJBofGez4CvAQaybZ4l/1jlmUBw7bCBQc4A9ttKFi+wpLf?=
 =?us-ascii?Q?L34zW+9HgGbz5JeXfE4Kn5BgTxBZ75GFjfD5vPh0CXTEtHY6le4V1aauQ1yY?=
 =?us-ascii?Q?Ryrw4G03xIsKUYSrzxMdbLmlCrlnYYLjlQedBOB13hGIoPdo58UaBNGC1tWz?=
 =?us-ascii?Q?i3A/OBxvHq7zDEpuVO7AIxBSJrRpFzE0fbny9pWHLQVMWJzY0AeRjlPa91rR?=
 =?us-ascii?Q?KR4ydsmN8WipxTpHyIvo0j7m8pDgX+c=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccacaeac-0172-4ee8-452e-08decaf6e503
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 15:58:08.7367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QkTEhosxX4gD92ru1Fv7Aa8kfhB3GZh44hJtXcz7HqKcSpY4sqOS6vU7+2x1pltgGQXMrjJ6roaOKB753q1WoiNBN+VW31xCqdMwrCPFtas=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1321
X-Rspamd-Action: no action
X-Spamd-Result: default: False [5.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	GREYLIST(0.00)[pass,body];
	FORGED_RECIPIENTS(0.00)[m:ukleinek@kernel.org,m:p.zabel@pengutronix.de,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor@kernel.org,m:emil.renner.berthing@canonical.com,m:palmer@dabbelt.com,m:pjw@kernel.org,m:aou@eecs.berkeley.edu,m:hal.feng@starfivetech.com,m:linux-pwm@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:krzk@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[hal.feng@starfivetech.com,linux-pwm@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-9295-lists,linux-pwm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hal.feng@starfivetech.com,linux-pwm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,starfivetech.com:email,starfivetech.com:mid,starfivetech.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7EC5D688CAE

Each of the StarFive JH7100/JH7110 SoCs has 8 OpenCores PTC IP
cores. One OpenCores PTC IP core can output one PWM channel.
Change the register size to 0x10, since an OpenCores PTC IP
has only 4 32-bit registers: CNTR, HRC, LRC and CTRL.

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 .../boot/dts/starfive/jh7100-common.dtsi      | 28 ++++++--
 arch/riscv/boot/dts/starfive/jh7100.dtsi      | 67 ++++++++++++++++++-
 .../boot/dts/starfive/jh7110-common.dtsi      | 27 ++++++--
 .../boot/dts/starfive/jh7110-milkv-mars.dts   |  6 +-
 .../dts/starfive/jh7110-milkv-marscm.dtsi     |  6 +-
 .../dts/starfive/jh7110-pine64-star64.dts     |  6 +-
 .../jh7110-starfive-visionfive-2-lite.dtsi    |  6 +-
 .../jh7110-starfive-visionfive-2.dtsi         |  6 +-
 arch/riscv/boot/dts/starfive/jh7110.dtsi      | 67 ++++++++++++++++++-
 9 files changed, 198 insertions(+), 21 deletions(-)

diff --git a/arch/riscv/boot/dts/starfive/jh7100-common.dtsi b/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
index ae1a6aeb0aea..85106545090e 100644
--- a/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
@@ -199,13 +199,23 @@ GPO_I2C2_PAD_SDA_OEN,
 		};
 	};
 
-	pwm_pins: pwm-0 {
-		pwm-pins {
+	pwm0_pins: pwm0-0 {
+		pwm0-pins {
 			pinmux = <GPIOMUX(7,
 				  GPO_PWM_PAD_OUT_BIT0,
 				  GPO_PWM_PAD_OE_N_BIT0,
-				  GPI_NONE)>,
-				 <GPIOMUX(5,
+				  GPI_NONE)>;
+			bias-disable;
+			drive-strength = <35>;
+			input-disable;
+			input-schmitt-disable;
+			slew-rate = <0>;
+		};
+	};
+
+	pwm1_pins: pwm1-0 {
+		pwm1-pins {
+			pinmux =  <GPIOMUX(5,
 				  GPO_PWM_PAD_OUT_BIT1,
 				  GPO_PWM_PAD_OE_N_BIT1,
 				  GPI_NONE)>;
@@ -359,9 +369,15 @@ &osc_aud {
 	clock-frequency = <27000000>;
 };
 
-&pwm {
+&pwm0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm0_pins>;
+	status = "okay";
+};
+
+&pwm1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pwm_pins>;
+	pinctrl-0 = <&pwm1_pins>;
 	status = "okay";
 };
 
diff --git a/arch/riscv/boot/dts/starfive/jh7100.dtsi b/arch/riscv/boot/dts/starfive/jh7100.dtsi
index 7de0732b8eab..90438df1f74d 100644
--- a/arch/riscv/boot/dts/starfive/jh7100.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7100.dtsi
@@ -360,9 +360,72 @@ watchdog@12480000 {
 				 <&rstgen JH7100_RSTN_WDT>;
 		};
 
-		pwm: pwm@12490000 {
+		pwm0: pwm@12490000 {
 			compatible = "starfive,jh7100-pwm", "opencores,pwm-v1";
-			reg = <0x0 0x12490000 0x0 0x10000>;
+			reg = <0x0 0x12490000 0x0 0x10>;
+			clocks = <&clkgen JH7100_CLK_PWM_APB>;
+			resets = <&rstgen JH7100_RSTN_PWM_APB>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm1: pwm@12490010 {
+			compatible = "starfive,jh7100-pwm", "opencores,pwm-v1";
+			reg = <0x0 0x12490010 0x0 0x10>;
+			clocks = <&clkgen JH7100_CLK_PWM_APB>;
+			resets = <&rstgen JH7100_RSTN_PWM_APB>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm2: pwm@12490020 {
+			compatible = "starfive,jh7100-pwm", "opencores,pwm-v1";
+			reg = <0x0 0x12490020 0x0 0x10>;
+			clocks = <&clkgen JH7100_CLK_PWM_APB>;
+			resets = <&rstgen JH7100_RSTN_PWM_APB>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm3: pwm@12490030 {
+			compatible = "starfive,jh7100-pwm", "opencores,pwm-v1";
+			reg = <0x0 0x12490030 0x0 0x10>;
+			clocks = <&clkgen JH7100_CLK_PWM_APB>;
+			resets = <&rstgen JH7100_RSTN_PWM_APB>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm4: pwm@12498000 {
+			compatible = "starfive,jh7100-pwm", "opencores,pwm-v1";
+			reg = <0x0 0x12498000 0x0 0x10>;
+			clocks = <&clkgen JH7100_CLK_PWM_APB>;
+			resets = <&rstgen JH7100_RSTN_PWM_APB>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm5: pwm@12498010 {
+			compatible = "starfive,jh7100-pwm", "opencores,pwm-v1";
+			reg = <0x0 0x12498010 0x0 0x10>;
+			clocks = <&clkgen JH7100_CLK_PWM_APB>;
+			resets = <&rstgen JH7100_RSTN_PWM_APB>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm6: pwm@12498020 {
+			compatible = "starfive,jh7100-pwm", "opencores,pwm-v1";
+			reg = <0x0 0x12498020 0x0 0x10>;
+			clocks = <&clkgen JH7100_CLK_PWM_APB>;
+			resets = <&rstgen JH7100_RSTN_PWM_APB>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm7: pwm@12498030 {
+			compatible = "starfive,jh7100-pwm", "opencores,pwm-v1";
+			reg = <0x0 0x12498030 0x0 0x10>;
 			clocks = <&clkgen JH7100_CLK_PWM_APB>;
 			resets = <&rstgen JH7100_RSTN_PWM_APB>;
 			#pwm-cells = <3>;
diff --git a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
index a7a1c09a2c90..64de468f2c31 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
@@ -326,9 +326,14 @@ uboot@100000 {
 	};
 };
 
-&pwm {
+&pwm0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pwm_pins>;
+	pinctrl-0 = <&pwm0_pins>;
+};
+
+&pwm1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm1_pins>;
 };
 
 &spi0 {
@@ -528,12 +533,22 @@ GPOEN_ENABLE,
 		};
 	};
 
-	pwm_pins: pwm-0 {
-		pwm-pins {
+	pwm0_pins: pwm0-0 {
+		pwm0-pins {
 			pinmux = <GPIOMUX(46, GPOUT_SYS_PWM_CHANNEL0,
 					      GPOEN_SYS_PWM0_CHANNEL0,
-					      GPI_NONE)>,
-				 <GPIOMUX(59, GPOUT_SYS_PWM_CHANNEL1,
+					      GPI_NONE)>;
+			bias-disable;
+			drive-strength = <12>;
+			input-disable;
+			input-schmitt-disable;
+			slew-rate = <0>;
+		};
+	};
+
+	pwm1_pins: pwm1-0 {
+		pwm1-pins {
+			pinmux = <GPIOMUX(59, GPOUT_SYS_PWM_CHANNEL1,
 					      GPOEN_SYS_PWM0_CHANNEL1,
 					      GPI_NONE)>;
 			bias-disable;
diff --git a/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts b/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts
index 21873612d993..54013c70f4b4 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts
+++ b/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts
@@ -68,7 +68,11 @@ &phy0 {
 	motorcomm,tx-clk-adj-enabled;
 };
 
-&pwm {
+&pwm0 {
+	status = "okay";
+};
+
+&pwm1 {
 	status = "okay";
 };
 
diff --git a/arch/riscv/boot/dts/starfive/jh7110-milkv-marscm.dtsi b/arch/riscv/boot/dts/starfive/jh7110-milkv-marscm.dtsi
index 025471061d43..31afac27b86d 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-milkv-marscm.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-milkv-marscm.dtsi
@@ -87,7 +87,11 @@ &phy0 {
 	motorcomm,tx-clk-adj-enabled;
 };
 
-&pwm {
+&pwm0 {
+	status = "okay";
+};
+
+&pwm1 {
 	status = "okay";
 };
 
diff --git a/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts b/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts
index aec7ae3d1f5b..a9e82f25efde 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts
+++ b/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts
@@ -95,7 +95,11 @@ &phy1 {
 	motorcomm,tx-clk-100-inverted;
 };
 
-&pwm {
+&pwm0 {
+	status = "okay";
+};
+
+&pwm1 {
 	status = "okay";
 };
 
diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-lite.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-lite.dtsi
index f8797a666dbf..85b56a72dff7 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-lite.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-lite.dtsi
@@ -74,7 +74,11 @@ &phy0 {
 	tx-internal-delay-ps = <1500>;
 };
 
-&pwm {
+&pwm0 {
+	status = "okay";
+};
+
+&pwm1 {
 	status = "okay";
 };
 
diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
index edc8f4588133..35208f95cd3d 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
@@ -73,7 +73,11 @@ &pcie1 {
 	status = "okay";
 };
 
-&pwm {
+&pwm0 {
+	status = "okay";
+};
+
+&pwm1 {
 	status = "okay";
 };
 
diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
index 9c3e4598747e..82ea63f715b0 100644
--- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
@@ -846,9 +846,72 @@ i2stx1: i2s@120c0000 {
 			status = "disabled";
 		};
 
-		pwm: pwm@120d0000 {
+		pwm0: pwm@120d0000 {
 			compatible = "starfive,jh7110-pwm", "opencores,pwm-v1";
-			reg = <0x0 0x120d0000 0x0 0x10000>;
+			reg = <0x0 0x120d0000 0x0 0x10>;
+			clocks = <&syscrg JH7110_SYSCLK_PWM_APB>;
+			resets = <&syscrg JH7110_SYSRST_PWM_APB>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm1: pwm@120d0010 {
+			compatible = "starfive,jh7110-pwm", "opencores,pwm-v1";
+			reg = <0x0 0x120d0010 0x0 0x10>;
+			clocks = <&syscrg JH7110_SYSCLK_PWM_APB>;
+			resets = <&syscrg JH7110_SYSRST_PWM_APB>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm2: pwm@120d0020 {
+			compatible = "starfive,jh7110-pwm", "opencores,pwm-v1";
+			reg = <0x0 0x120d0020 0x0 0x10>;
+			clocks = <&syscrg JH7110_SYSCLK_PWM_APB>;
+			resets = <&syscrg JH7110_SYSRST_PWM_APB>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm3: pwm@120d0030 {
+			compatible = "starfive,jh7110-pwm", "opencores,pwm-v1";
+			reg = <0x0 0x120d0030 0x0 0x10>;
+			clocks = <&syscrg JH7110_SYSCLK_PWM_APB>;
+			resets = <&syscrg JH7110_SYSRST_PWM_APB>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm4: pwm@120d8000 {
+			compatible = "starfive,jh7110-pwm", "opencores,pwm-v1";
+			reg = <0x0 0x120d8000 0x0 0x10>;
+			clocks = <&syscrg JH7110_SYSCLK_PWM_APB>;
+			resets = <&syscrg JH7110_SYSRST_PWM_APB>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm5: pwm@120d8010 {
+			compatible = "starfive,jh7110-pwm", "opencores,pwm-v1";
+			reg = <0x0 0x120d8010 0x0 0x10>;
+			clocks = <&syscrg JH7110_SYSCLK_PWM_APB>;
+			resets = <&syscrg JH7110_SYSRST_PWM_APB>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm6: pwm@120d8020 {
+			compatible = "starfive,jh7110-pwm", "opencores,pwm-v1";
+			reg = <0x0 0x120d8020 0x0 0x10>;
+			clocks = <&syscrg JH7110_SYSCLK_PWM_APB>;
+			resets = <&syscrg JH7110_SYSRST_PWM_APB>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm7: pwm@120d8030 {
+			compatible = "starfive,jh7110-pwm", "opencores,pwm-v1";
+			reg = <0x0 0x120d8030 0x0 0x10>;
 			clocks = <&syscrg JH7110_SYSCLK_PWM_APB>;
 			resets = <&syscrg JH7110_SYSRST_PWM_APB>;
 			#pwm-cells = <3>;
-- 
2.43.2


