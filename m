Return-Path: <linux-pwm+bounces-8879-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAV6Jvu9BmqMnQIAu9opvQ
	(envelope-from <linux-pwm+bounces-8879-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 15 May 2026 08:32:27 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4F254A03F
	for <lists+linux-pwm@lfdr.de>; Fri, 15 May 2026 08:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 863AD301E212
	for <lists+linux-pwm@lfdr.de>; Fri, 15 May 2026 06:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F38537B3F4;
	Fri, 15 May 2026 06:22:06 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2109.outbound.protection.partner.outlook.cn [139.219.17.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA31935CBC3;
	Fri, 15 May 2026 06:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778826126; cv=fail; b=B+TQwRtXHCTL0qseyNUaTjibnZ15Rj0hxTH+TnC3MJ+DfYclE/UFpaxASkuUyZAIFevaKc/C/jtP4ZXZtQbq0HUYFeaXat3tb4qqzgJJ2WsPQ81nLzR4oFDXGV74VSLmPgSG5Pf2YN7okUkmF7aBGKMt3CO+JWh4JAhJJHWgpOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778826126; c=relaxed/simple;
	bh=8Ovq9YxJAqBQs10MPKgl+MRFDNyQLnWR8e+CZKogHEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rk83Cu+bvw9QdXY8Zdnm5z+HrKN8HeZT6iRw/Ef6XdUYfFrlRgngJqfjgwGFFay1D4PrLL6VvuelEBunatA5IAeuDSZU52JpavBxfTRNxR+EW6WEJWboN1nvsXql8K8fsfnFIM44RcBJ+GAPcsN9Xgwjn50CFanm4ELyrXxEdO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oTxNwFj+U5lDpbv16sEWHyFTb6wslbqgdJ9XoO8UuzByUExHfHTRAVEQfA4w4A2w1Ew43njI3Kz/G3nz9olZFKdaARbjhU5FjjwWziUrCdLrOmfJw7A9lED8kUer9AK2QzTxteKRkJj9r3Kxg7ExhIaXgt3EvnN7DDMfGxuhzkrtN8F6qrIrn3AUf7y5+1Mj68Yp95r8p3XoD+Jn3MiQSl8YKjeE4t24lwRS2boJ8Y1C6aUcphznYi5j2JjBnL0Q9O2FQlDmrDsIuCWucEgHCpMocO2PPZkpeYghVEK9lPm6IN2j9Vo3FGmQquW+9Q+OZDp/78mjqdgRYQAHBQnJ5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ZYYZjaF5OePaKfu4ka3nc+Ja1B53Rjud8gvilZ5QUo=;
 b=UZHfHCDqyMX2FeZEs7rFqBAShpzvK2Ql7aL28Xfx7YwmbbckIBvAJ2Surj3g4OfdAEogvrJK+Gq4IOCOldmS38qqPzrvHdwTQK/+IoseMe+23eBiXyaZAMyRkw1GC4rN8CPUIcrjxBubPtehnqAYaawswiVqCMxAxmnOBeXwgz3bAN5E7TtgRl/dVY68Qwt2Xc8grzJiu4hR2qIzimvLo6NOFTdDKvhHyb4Bgv1TGdQZRx/qtLA8/3AmJ/0uZvMikJgtETCploR7QA9hBOfViPu3pVVNcWeT3owLW/iOKFARZwHdpFSqqz3STSDTW9oq0KGx6mvCAmi8PrA6K2QyqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1276.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:10::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Fri, 15 May
 2026 05:47:33 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::4386:5cc4:3bc4:4795]) by
 ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn ([fe80::4386:5cc4:3bc4:4795%4])
 with mapi id 15.20.9913.009; Fri, 15 May 2026 05:47:33 +0000
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
Cc: Changhuang Liang <changhuang.liang@starfivetech.com>,
	Hal Feng <hal.feng@starfivetech.com>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v18 2/3] riscv: dts: starfive: Correct pwm nodes
Date: Fri, 15 May 2026 13:47:21 +0800
Message-ID: <20260515054723.25024-3-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20260515054723.25024-1-hal.feng@starfivetech.com>
References: <20260515054723.25024-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0013.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::22) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1276:EE_
X-MS-Office365-Filtering-Correlation-Id: 958f09c7-6672-4f82-79e2-08deb24575e2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|56012099003|18002099003|22082099003|38350700014|3023799003;
X-Microsoft-Antispam-Message-Info:
	26tbQgFqIcr5nYFgKrSgrTeDRv0iS46Y26iepQyxDiphl9NoEhbFC3qtWR0iTYuivmpwJSka8jp9oEJap2hiTq5Cdyqzmet8gt4qjxNht7BDY9OMpWibUPvR7ZrZNQjclHeXY8KDigmRY8K49QkSaAR9GHSA6a5gIiQr1uRRpvA1ul9X82j8Iomy1o63aNa6kBYqrwx9l0azE4PYTD/S25nTr4pJGC8QtakDdQJ8L4jSRG9pNish15fjlmVHySu6kVZ4BvYfBzL/agzgx0PV6Ao9ybIwduTkdV+w9D9o3v0So2v4zZfTj7RoNBhsLuX4OxJVZpUkbpFsb/7guOL3fNBJeD5soHx9F+mqBu8W4JwHDYTFe993jZ/BivG0R2QukHqjgjyZQEebEC5SYmaVHj+oThuQVvhrr6X9viABYqk9ERiSyH863fNvDHFeMg4z2Z4E84xGuzFD+sc3XzEWyf+FWlGUgxJDqRa5KMT/8N4zjnNi0hut9y6yDbMJO+KmUHWB9gTpTu1GtI3ED/JoxOyl6y0bylMykQQ0hxaHxKKA8WnZ+ZA+qlrc/zI6c3cy
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(56012099003)(18002099003)(22082099003)(38350700014)(3023799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4jTn6owov5OBSnAV4W1K8OxA5DhdzLFgPRKVoKSSdsmO1PTEZnsJGLcxyY3f?=
 =?us-ascii?Q?hurov/ixnnMzKJSOb7e/6VdC9mjYiFt9ISa8fkVUrH6gHIhnn29tQJUtVovt?=
 =?us-ascii?Q?mBu+03SDhgXnOrmuOqph19W/vZPtInMgLrnuwdgp5qnubVYuxAttcEYjaYrF?=
 =?us-ascii?Q?WgCj8fKsPFFF4gilotknvFOFNycVaLxPXQD2h5qibI/nanrd52ZLZ2hv8c54?=
 =?us-ascii?Q?QHjK+uISXJXZ/yy5KT+1/Gsw6OW8eSbGrU4sRCYyj2atGEO4URGRQAL7Cw4y?=
 =?us-ascii?Q?rO8pUsH8HjZziLnpHXIuAa7nutcZAA80jvSDEwKyu+CKG1IZeg1+5CEbyop4?=
 =?us-ascii?Q?GAunH8Y89g0FxwXAPWH3dCr9MZ2zPsqyFjB7HXAl1LxX+JoxBTSVwQtMi4GM?=
 =?us-ascii?Q?Zyq0NlpbkmG0TQiWFZOhZd1SB8OEy9hIqiklFtHxIsf/hQ6K5hMqLElptv0r?=
 =?us-ascii?Q?W53mmBVWcM4iQ2Hz1LpUPQ9GX7arRiogqHGT8WfB943HaVN0XiosBcTygUWT?=
 =?us-ascii?Q?cMmIxfHXc6NGyuHyMHW1hwLXmrvKe/rLhkOkSTMk80Y4J8n9i0/Z0/cUDWgl?=
 =?us-ascii?Q?BKjh8AkV3FpIojkJs2DV4NSLvbtH+na9q+2X7MJle8HwnwrT7CjdP4cNr9NE?=
 =?us-ascii?Q?HuWtCEM846+qCCSqipgM2VCFQwypW6P+lGiMLMa8zcwvSySu5Oc25ramIco6?=
 =?us-ascii?Q?R2GydCv2edwbaVQXLYH/xU8KKlT4EGrgQpLv/hn4yQHNg+DGCPJl6XH/xBQx?=
 =?us-ascii?Q?B4WJswbtQRsri6utEWcLMfMn4Z6MdsN/noqiOoNv+NAGLUlnEVGub/8D58I4?=
 =?us-ascii?Q?RnPfuDWjP6s+fhgzpM4eqgMirSfeXd9JKo4RaOy6Uh5RFKvgblmL9br5E7Nu?=
 =?us-ascii?Q?946EH9u0EV4R8gA0DIEyjPCzEv7jospfS1wLH0s/qkVg2ZnHpw2L9k9hUfA5?=
 =?us-ascii?Q?Xes0FtTGkVuBRI1nluQVlkgxik3ScOn/irRhpOq441CsKm3X6PgmTMYsqLW8?=
 =?us-ascii?Q?XPVdkyTM3trJA/WhdjZ0A7dtGB1STxkhQBUgLBe2Rnqv5lXy/DEuD85k6Pk5?=
 =?us-ascii?Q?iQ+/xXVyPRLBiRJqBnTXuyGGnjVMLHRQWHczmRN6bDqW8Fd9UVnlJrP6dO65?=
 =?us-ascii?Q?Qd4jaKw1z93SncigZozmdPTIrDNQpqgOjxoPPxvdPouWo0Rwt6W2XUY7ov0g?=
 =?us-ascii?Q?z1Ky6DRsA/eknPK7kP1CUb9aeEGBBYZFvXJwEfPw2jO3Cqux1+sYJDTmeHTc?=
 =?us-ascii?Q?8FwL6DmSc+vb4VD6H2TZt1Z6jfuxqY61O2jTajzNMSE6NPcUwSTkHPuZ4xza?=
 =?us-ascii?Q?5QNY5HculYu76Fuctu+L/G+Xu3KKKJnFruqBkhRtxdjpbLVEKAhMVISYP8zL?=
 =?us-ascii?Q?wiS6/ELGVK+8PN4VSg4V7ay9AmVdTxWJVczNG1cg7OuJqpEvJF9xnWTMnFkW?=
 =?us-ascii?Q?enUZIUmKTzkyrEuSczwoEaN93dpOw0IQSD6nuyBnAegPeWN3vnHdiYUkaRIT?=
 =?us-ascii?Q?aS+AqD98rk0HPG50YTcHZRe1fZYGh4t32/KYYgxXIdZj19X8QxlrA4Bqk/Qh?=
 =?us-ascii?Q?QJvMYT5nkqc2MDOlPps3V1oU1KPdqDjnFNd6ESTGEWuu9RIfhnEloA7puo/6?=
 =?us-ascii?Q?jHUfXkFnfIC+cLkTwYbs1EBfC3s5I9IH99tql2E6xS3AZnmL4RU1pSXbsUAD?=
 =?us-ascii?Q?1ZMFCSGpkJez6cIKaFDYw8j1rjwiXXJGviX6GzQQQmaSUCLkgKMjDej5LNha?=
 =?us-ascii?Q?uUVEfd3w0hck4wwFHA3tOxPVAamWtS4=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 958f09c7-6672-4f82-79e2-08deb24575e2
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 05:47:33.5195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qDk/52otvWK5/9Nv0Lvp3Z/4ixqWUw9Qb8qvifCW0lf7wHmlIQ6GV09cONYePQ68eaViw7laXwzM0oTMEJN/WkbbpDnol50mPlTEXbM2cvM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1276
X-Rspamd-Queue-Id: DC4F254A03F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [5.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	GREYLIST(0.00)[pass,body];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8879-lists,linux-pwm=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hal.feng@starfivetech.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.907];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Each of the StarFive JH7100/JH7110 SoCs has 8 OpenCores PTC IP
cores. One OpenCores PTC IP core can output one PWM channel.

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 .../boot/dts/starfive/jh7100-common.dtsi      | 28 ++++++--
 arch/riscv/boot/dts/starfive/jh7100.dtsi      | 69 ++++++++++++++++++-
 .../boot/dts/starfive/jh7110-common.dtsi      | 27 ++++++--
 .../boot/dts/starfive/jh7110-milkv-mars.dts   |  6 +-
 .../dts/starfive/jh7110-milkv-marscm.dtsi     |  6 +-
 .../dts/starfive/jh7110-pine64-star64.dts     |  6 +-
 .../jh7110-starfive-visionfive-2-lite.dtsi    |  6 +-
 .../jh7110-starfive-visionfive-2.dtsi         |  6 +-
 arch/riscv/boot/dts/starfive/jh7110.dtsi      | 69 ++++++++++++++++++-
 9 files changed, 200 insertions(+), 23 deletions(-)

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
index 7de0732b8eab..4629e9747307 100644
--- a/arch/riscv/boot/dts/starfive/jh7100.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7100.dtsi
@@ -360,9 +360,72 @@ watchdog@12480000 {
 				 <&rstgen JH7100_RSTN_WDT>;
 		};
 
-		pwm: pwm@12490000 {
-			compatible = "starfive,jh7100-pwm", "opencores,pwm-v1";
-			reg = <0x0 0x12490000 0x0 0x10000>;
+		pwm0: pwm@12490000 {
+			compatible = "opencores,pwm-v1";
+			reg = <0x0 0x12490000 0x0 0x10>;
+			clocks = <&clkgen JH7100_CLK_PWM_APB>;
+			resets = <&rstgen JH7100_RSTN_PWM_APB>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm1: pwm@12490010 {
+			compatible = "opencores,pwm-v1";
+			reg = <0x0 0x12490010 0x0 0x10>;
+			clocks = <&clkgen JH7100_CLK_PWM_APB>;
+			resets = <&rstgen JH7100_RSTN_PWM_APB>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm2: pwm@12490020 {
+			compatible = "opencores,pwm-v1";
+			reg = <0x0 0x12490020 0x0 0x10>;
+			clocks = <&clkgen JH7100_CLK_PWM_APB>;
+			resets = <&rstgen JH7100_RSTN_PWM_APB>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm3: pwm@12490030 {
+			compatible = "opencores,pwm-v1";
+			reg = <0x0 0x12490030 0x0 0x10>;
+			clocks = <&clkgen JH7100_CLK_PWM_APB>;
+			resets = <&rstgen JH7100_RSTN_PWM_APB>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm4: pwm@12498000 {
+			compatible = "opencores,pwm-v1";
+			reg = <0x0 0x12498000 0x0 0x10>;
+			clocks = <&clkgen JH7100_CLK_PWM_APB>;
+			resets = <&rstgen JH7100_RSTN_PWM_APB>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm5: pwm@12498010 {
+			compatible = "opencores,pwm-v1";
+			reg = <0x0 0x12498010 0x0 0x10>;
+			clocks = <&clkgen JH7100_CLK_PWM_APB>;
+			resets = <&rstgen JH7100_RSTN_PWM_APB>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm6: pwm@12498020 {
+			compatible = "opencores,pwm-v1";
+			reg = <0x0 0x12498020 0x0 0x10>;
+			clocks = <&clkgen JH7100_CLK_PWM_APB>;
+			resets = <&rstgen JH7100_RSTN_PWM_APB>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm7: pwm@12498030 {
+			compatible = "opencores,pwm-v1";
+			reg = <0x0 0x12498030 0x0 0x10>;
 			clocks = <&clkgen JH7100_CLK_PWM_APB>;
 			resets = <&rstgen JH7100_RSTN_PWM_APB>;
 			#pwm-cells = <3>;
diff --git a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
index 8cfe8033305d..5aa225b8bca8 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
@@ -351,9 +351,14 @@ uboot@100000 {
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
@@ -553,12 +558,22 @@ GPOEN_ENABLE,
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
index 6e56e9d20bb0..e6b9b02bf8b2 100644
--- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
@@ -846,9 +846,72 @@ i2stx1: i2s@120c0000 {
 			status = "disabled";
 		};
 
-		pwm: pwm@120d0000 {
-			compatible = "starfive,jh7110-pwm", "opencores,pwm-v1";
-			reg = <0x0 0x120d0000 0x0 0x10000>;
+		pwm0: pwm@120d0000 {
+			compatible = "opencores,pwm-v1";
+			reg = <0x0 0x120d0000 0x0 0x10>;
+			clocks = <&syscrg JH7110_SYSCLK_PWM_APB>;
+			resets = <&syscrg JH7110_SYSRST_PWM_APB>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm1: pwm@120d0010 {
+			compatible = "opencores,pwm-v1";
+			reg = <0x0 0x120d0010 0x0 0x10>;
+			clocks = <&syscrg JH7110_SYSCLK_PWM_APB>;
+			resets = <&syscrg JH7110_SYSRST_PWM_APB>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm2: pwm@120d0020 {
+			compatible = "opencores,pwm-v1";
+			reg = <0x0 0x120d0020 0x0 0x10>;
+			clocks = <&syscrg JH7110_SYSCLK_PWM_APB>;
+			resets = <&syscrg JH7110_SYSRST_PWM_APB>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm3: pwm@120d0030 {
+			compatible = "opencores,pwm-v1";
+			reg = <0x0 0x120d0030 0x0 0x10>;
+			clocks = <&syscrg JH7110_SYSCLK_PWM_APB>;
+			resets = <&syscrg JH7110_SYSRST_PWM_APB>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm4: pwm@120d8000 {
+			compatible = "opencores,pwm-v1";
+			reg = <0x0 0x120d8000 0x0 0x10>;
+			clocks = <&syscrg JH7110_SYSCLK_PWM_APB>;
+			resets = <&syscrg JH7110_SYSRST_PWM_APB>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm5: pwm@120d8010 {
+			compatible = "opencores,pwm-v1";
+			reg = <0x0 0x120d8010 0x0 0x10>;
+			clocks = <&syscrg JH7110_SYSCLK_PWM_APB>;
+			resets = <&syscrg JH7110_SYSRST_PWM_APB>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm6: pwm@120d8020 {
+			compatible = "opencores,pwm-v1";
+			reg = <0x0 0x120d8020 0x0 0x10>;
+			clocks = <&syscrg JH7110_SYSCLK_PWM_APB>;
+			resets = <&syscrg JH7110_SYSRST_PWM_APB>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		pwm7: pwm@120d8030 {
+			compatible = "opencores,pwm-v1";
+			reg = <0x0 0x120d8030 0x0 0x10>;
 			clocks = <&syscrg JH7110_SYSCLK_PWM_APB>;
 			resets = <&syscrg JH7110_SYSRST_PWM_APB>;
 			#pwm-cells = <3>;
-- 
2.43.2


