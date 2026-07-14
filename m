Return-Path: <linux-pwm+bounces-9705-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rKx0KaS3VWrArwAAu9opvQ
	(envelope-from <linux-pwm+bounces-9705-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jul 2026 06:14:28 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1280C750C53
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jul 2026 06:14:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9705-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9705-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=starfivetech.com (policy=quarantine);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CEFF3061601
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jul 2026 04:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2811A2D9EDC;
	Tue, 14 Jul 2026 04:04:50 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2095.outbound.protection.partner.outlook.cn [139.219.146.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1616930F927;
	Tue, 14 Jul 2026 04:04:44 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784001890; cv=fail; b=WnJRk+OhHY6vrxF2oXdi4NDD6v+A3gXTfE9HG41UqvDf72THGSe7Iv2FylhE6vKtnA2GHOqjHO6IOeval8iIZrIRvznoWm2YKB7dVJBv07PLtZc0J8IKzOjaiPsolWSJ/oD7SNvRr9ehqZQxoQfAOrwiF5Ez4kdYlqmTD3L0oDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784001890; c=relaxed/simple;
	bh=mW3Obbi7ZNnF8KGepPlAyepjebbbRirAs1zV0C8olkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HJZAt40QgLPkUhMKWGlk3mQhK088YFyc+B7DrcwgVb9DEf4XmCNZhBAPMYkvwPXU1CTjMo64gLakGA5pdUixxn+WAnrCwV7I9K4RYIID8YZmvQSq/fuUJ9TAA1iBVP2QJgVFiBLGMwKQdHApHyH6QOCOLP65Wsi4/aobTT9MrAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.95
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PpzpXOy3eUFbkPb1RYLDl3H2xDND2DC2cvOg8b/kpeE5yCJijXyEs6vWR1A2LbEtyw3I2y0Ymppeg+hiHwURxUucwY783B7UcuPVvSy3mDF90ym+hPVMQQp99s5MulpnfiOhZLX0Y9MVBMkypPjrW6Yk92y9phCwToBIlZByaE0Wh1aq/rZOXx1MDKI9RKdYFxebeTHWar5uraMt7GI88SGevusDayH3lSkPcbMQi/feOcf1rObER6llKbMySJp3D7AOmfrA6Viu/nFH2yphLMuWyfhUrzjY5kp+Qw5D8zwCvViQWGCdpz8f0TUfNrsLvD/AvFgs+o/It5Ex/rfeHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YD3IboAnPkUzVxwkee6yCSeA50vzochcqZ48GkMsiXM=;
 b=CDQ/hVBHFUFOxK7Gi5qC/eT+hHNc01fEKrCofq6RnzGLx3i5wuPGTljJ/3Zy9nuO92+D02viVtlFx59I60x2M8BDM1q1iha62TmixFC6WqInqp72RV/FgObEHJTzybwIDL8S/H1BNFRS+ayp5x5STa3E5VP3KEE5DlFCf3mpiLidGzTlkEYoEivXSer7Db7Jh0Kn/Llr7k8+fq57od3FIEW1SBaZmYraKiQ/5x8HnD3AiSmJPt/oHKgPCis7N6m9RpgyV8SOx15u2/HtmQJeJfB8Th9BeDb8lSpVDqsial8rVrS0eba74agXJPUHcctWcu3NAh7IPFhP6l/dZ2kg9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1324.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.23; Tue, 14 Jul
 2026 03:31:00 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::4386:5cc4:3bc4:4795]) by
 ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn ([fe80::4386:5cc4:3bc4:4795%3])
 with mapi id 15.21.0139.024; Tue, 14 Jul 2026 03:31:00 +0000
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
Subject: [PATCH v22 2/3] riscv: dts: starfive: Correct pwm nodes
Date: Tue, 14 Jul 2026 11:30:49 +0800
Message-ID: <20260714033050.44952-3-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20260714033050.44952-1-hal.feng@starfivetech.com>
References: <20260714033050.44952-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SH0PR01CA0023.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:5::35) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1324:EE_
X-MS-Office365-Filtering-Correlation-Id: dc56007f-fa74-459f-4dd8-08dee1585370
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|52116014|376014|1800799024|366016|56012099006|38350700014|18002099003|3023799007|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info:
	pHxO55dUFD/YYnHnZAJMjAfP3+nfXWKBBdXCbATTAOqljfX3FVutOkh2uCmok7kFC54SwrsysUNJJtE7795wASZqcNCpEaF7RbispzAgUZCj2bFFR9JruD++o2uHZbfGrGFAFIkvWKvotM7+U+1Qft2Xnd5x9Iw5K7FytRLrmUHtOdx1w/xZAzthUGyaQKF0+Zc2h8rUtqMGiKzYhSUoDloVqnpoT4wL0mu53dcJ+c+5PNzfxdrrTAPVPzgV0g/m1Qx2RrqMqEvTY1tPB7hpd5QGUDgt+1nECFVWtf2JmJjqEG3nCs1UjHqI2C13+tYUVt7Tf/J4X03JIlJt4hcHiG23i2mmdFbuIS70BwvSprvs/1EPjHfIlZA6ZGd9lpo/YA7I/FUpvg5351nkV5cRTJy8PaiSvhUzW9zekF7kPyox22K/4WEOvCqEdsw4Tu1IQAzAsn+3PV38GCQJD84vG/awFTNlknkBasrcuy1cZK0k00vZ71ydmZVLtGEjcKTEltZWWmR/MJG+auEf8dl45dLkBZjHn2CYZzYhlgMsf5ledisX2Gga4kF8bvsNTm/N
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(52116014)(376014)(1800799024)(366016)(56012099006)(38350700014)(18002099003)(3023799007)(6133799003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fCSt6vVUycV81TCGXx4X5y3vMTyhNkoy0SRyhMA7r7NVflz8u5NlSOe8EAUu?=
 =?us-ascii?Q?cVQSILH+a6hBZiICtMj87+tQ89z2Gg5BdyxpGyb8MAIciCwsib9eYg4NCP6h?=
 =?us-ascii?Q?G+ZFOZBOQML0J4PtfDg5KSzXu5yv4A6Eo6cvOkB95jyfb6dvLiuNVNhc7qcP?=
 =?us-ascii?Q?IxhPd4QZmbXidsPQ1BCV8RPneoOn0wtKkvFFfFO4ZH8l1XNDwDVFh8VhyPNQ?=
 =?us-ascii?Q?qkhC6aYQ3692Ukzmdu8TetKzzXOviyUeaolS/aLMcwSGbpvL42L5cNXIBVCV?=
 =?us-ascii?Q?Afg0gNG5Z7qYaCEsWTX5IaNZD3JzFyIgB09waexWQ7k4stdnAt9gaGommYok?=
 =?us-ascii?Q?3/0033kR8DAZZqnQkz/02IBgEzRDLysVwXOAoSdMSDJJRRZ2/rhhgf3UaegG?=
 =?us-ascii?Q?/ukn2DIxkkKrqn3KCCt9s6vpsjs1Ni8or4n/5pRuIucJruqYEEyTPrCSOxmD?=
 =?us-ascii?Q?qKUUjuxTW0HkQ+7E8ypLioZC90UTJMlglArNmHi7wqwUW9COpkHbEJLzPzU7?=
 =?us-ascii?Q?tE9i/lJsLJMyfDVlhDBrEvOBUch27Yg5Aq2q2tKFYtoLVNoz4iTo/h+ipa9E?=
 =?us-ascii?Q?HE+QHcPU5bh6rBGJ2zAyIuAEXFxqVtvahSTkM2ua+GPCk0SCpGSq7oq0FfH8?=
 =?us-ascii?Q?3QI31dIJXwlz9L4uLc+Qpi+RUmSGOwTgyg1emZVaT9obmFxxeKbOtvhyOUJx?=
 =?us-ascii?Q?5Od7aWaXyh4qYdjrqoPDqSMs2EcMBJyOulHigBw7akDbwyZgB20SaL+1Guzh?=
 =?us-ascii?Q?TZuakgM1fjd2aCAmjj7iXaso5Hr/Llx0eFlvQq+FfED5jRxE6lQFweclXm41?=
 =?us-ascii?Q?8Io8ScngCGZlRSMdx2CcGNeITnbADPFy/TIrpQ7sOxYWxc7MBQNPOv5I01Sg?=
 =?us-ascii?Q?6NbGt8g0ZB2kCBPY0vQxIm4Tb23dDdqECraWFSiCDRLHvv36zDY6oXkZAlJ2?=
 =?us-ascii?Q?vImmZUpvANHk+jP6STzbhQvvIQnnVj2pLOF90amBu4v5PbbmF4v/2Kv15p9o?=
 =?us-ascii?Q?ccMabiPF59sP4KoXwMcmAKB6+oZtag5W5cstYSIPl09gVbdHkfBbXHI0ozso?=
 =?us-ascii?Q?nnSZmUswVxC0Xqq+S7Xzdg5reDcyRNSAN/OG06lljelio6PisCm6bh1t0vYb?=
 =?us-ascii?Q?vQ5JgpVHUzJqtqI4PlLMXsMbHPf1/BdLHb0PLhPwHUChU8WkcMoIr3Ejwrl2?=
 =?us-ascii?Q?eLiMVaNaN207vkxzAmLxTpWD/5cditoq8JelfFgX7kD/jf/dK0QioDKr6j/F?=
 =?us-ascii?Q?7U04/0kfsiesowlNpg+SWPnCSpSfU9hBPPDcokanX/aRFU2YtmmqMzA3YfCJ?=
 =?us-ascii?Q?5kBFS7GP+SsnBGIMGkMsMpjI0tVDPraSRKK4zZVdXSXp1ST51ZOCtJgnn/EJ?=
 =?us-ascii?Q?Qw6SO0vODrJSj2UY0r+tjpLNiCQdMYcajkSQmZXh0Vd2yu+ykw50tV4IzNPw?=
 =?us-ascii?Q?Pjx1Zts6ZP60YiJBiRrwXDKRF66L/FUREgj1EGJa3CJgW0CFTuPMZg47KWGP?=
 =?us-ascii?Q?gGPuypYgeSQbk0zX8BoiOXWtPUxe/h6CF/lg+bvSmmKxqPqEX6CWaUL+7o4D?=
 =?us-ascii?Q?AaYzILgC0qRKTgC8VnbsOp/IZ2LTVaUH7nDOcXhrmtLU9EJRaKXzP53GNDtH?=
 =?us-ascii?Q?tm8FyHMT4QYvAw4hu4K5gfwWpkWGhTonV0+4YDs3YE9Q5w2mo8fo3boYVu2R?=
 =?us-ascii?Q?orGQz250fx/zw6lmwVI6z6/kYYV04K1390cGgEhu/ba9jsR4p0UBJnIWrCzK?=
 =?us-ascii?Q?iVGfK4Cm1iV2KpxFcyE9fjwJ6zprB9k=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc56007f-fa74-459f-4dd8-08dee1585370
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 03:31:00.7687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w1i9ra5eRS5ZVSiI/e8/GnmO/XnllWU0vD0LRCaZeVQOzpfGL//4hAxybzCB2AmE5k2MoXZs5ZopVvNk7BM62yMzpEKcnvcIrPgdHltytl0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1324
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
	TAGGED_FROM(0.00)[bounces-9705-lists,linux-pwm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,starfivetech.com:from_mime,starfivetech.com:email,starfivetech.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1280C750C53

Each of the StarFive JH7100/JH7110 SoCs has 8 OpenCores PTC IP
cores. One OpenCores PTC IP core can output one PWM channel.
Change the register size to 0x10, since an OpenCores PTC IP
has only 4 32-bit registers: CNTR, HRC, LRC and CTRL.

Fixes: 8d01f741a046 ("riscv: dts: starfive: jh7110: Add PWM node and pins configuration")
Fixes: 5e598b99fedf ("riscv: dts: starfive: jh7100: Add PWM node and pins configuration")
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


