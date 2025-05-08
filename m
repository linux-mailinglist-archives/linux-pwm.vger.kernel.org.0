Return-Path: <linux-pwm+bounces-5851-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8481BAB06A0
	for <lists+linux-pwm@lfdr.de>; Fri,  9 May 2025 01:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B9733A3582
	for <lists+linux-pwm@lfdr.de>; Thu,  8 May 2025 23:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1C022129F;
	Thu,  8 May 2025 23:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="oJr1jKcB"
X-Original-To: linux-pwm@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010022.outbound.protection.outlook.com [52.101.228.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DA12101BD;
	Thu,  8 May 2025 23:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746747616; cv=fail; b=OmokiN/+hhSht1RIb7p0QnCjdWy+PGKuHHX3aLoznvLVWDl9AhwQ+25yv+MJh3N3AsasMMdFd8+gUe4A1C435bDWEdxhlbYXxFfWm6oOaemsaliBENjaBm+dhJB7lFZqMOycAI6YSeQwZVQBnU6UsZuIDEcaHFRtvFBRHyjafMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746747616; c=relaxed/simple;
	bh=8KVLdcivKlR4DkkYRwrXJuwaYBsE3pOR3ar6Qq5INi0=;
	h=Message-ID:To:From:Subject:Content-Type:Date:MIME-Version; b=AnR/JI4iJV78lQ8liLftetpOdBfsSU3aooTmg3XVDn3KfO/u5NhhyrGoAUdDjhmNZTSN9TGTU2n9eR/NAQPLblFxqJydbv5308Cj5NaxfdjQ4R0Mw9VErrmvzTXDaLoTSXDNyAceCx4hXEtYHaX7nngGDX6UWNI8D0ETt7rZjvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=oJr1jKcB; arc=fail smtp.client-ip=52.101.228.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=njVPuVMUXnQzq97ZUV33+DG47gNSCzSnA9IvBImvO/H/P+cTCVjlsZ8Mj40c/u+7wFFOk9xX+CGKvclAS87eU109bTAbsncaJq0nxOt1Owp+QVFXZp1L3w1C5YNP3w9hYmqkyRtU2bG1yMNMB0aYu/IDRAzYIiUYeB2TnTBYCgbV9PW8s6HnrsVIVe7XbFTE4taZqXAsF0gku26+rsngO+YYBPO3lXy+MaapJwx2EHTV2xMNL17tbcqJnZWb2Sq9npEoaOUMqWSltLQl/6BlxWomZov6RSZJrztj2tJw4++0Ym/gICmu0dovF3LhqBmRhu5P+8+2F8NnJuSkXdYnaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u0q4cXbn/jBxp17Yldw2wv70PrQliHAr3WnMAS+K7sM=;
 b=agXNkLrYRp0E/0P/K+VXeTSkf923u95ZsocXT1BzP5ZNL4JCGK4SsE7rW4zDlLTokQWawE3fdTdh//JoqT/hrfBfxRFC8zHGPHnQbyeZ/JdHxgdru9E+IwTK9FQXCjPogWoHqduWOSkTb0IY4h2U0BH6Ak/v0UOIt6x3xW5i9HiRpdCiS0eybBhyU65kQ6Ug+OE2wYXoFerXQcJC1x8JghVwAg4hbnc9Xf2sEmjEJcs4dSVVF2M+Kb3hKkr72MSnkWKoa7xFujzrg+rH14eZtCzdp5n5RyLIo2BDkNGb8UIz0io8jwzjKYungCAnRa+p4SHDEdVRbaNXOF0J3mQxzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u0q4cXbn/jBxp17Yldw2wv70PrQliHAr3WnMAS+K7sM=;
 b=oJr1jKcBjopXP/MFE30mn7Kk2oz1lmcNYEj1VaoGxOCxeITYDh99WlS0rtEEAE9qakR7hEB7evy//JozB2GRWN0nYxlqEdMdbYTkBywIHfw9V0jRDKwxXm+9itBHB4AolHIg4bC8mzvqDJWHtoZ5wv3Ht8zxBgWH/I3HKwuEfWY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TY3PR01MB10906.jpnprd01.prod.outlook.com
 (2603:1096:400:3af::14) by OS7PR01MB11424.jpnprd01.prod.outlook.com
 (2603:1096:604:246::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.25; Thu, 8 May
 2025 23:39:58 +0000
Received: from TY3PR01MB10906.jpnprd01.prod.outlook.com
 ([fe80::592:9b7b:ef57:2dd8]) by TY3PR01MB10906.jpnprd01.prod.outlook.com
 ([fe80::592:9b7b:ef57:2dd8%2]) with mapi id 15.20.8722.018; Thu, 8 May 2025
 23:39:58 +0000
Message-ID: <87r00ypt81.wl-kuninori.morimoto.gx@renesas.com>
To: =?ISO-8859-1?Q?=22Uwe_Kleine-K=F6nig=22?= <ukleinek@kernel.org>, Catalin
 Marinas <catalin.marinas@arm.com>, Geert Uytterhoeven
 <geert+renesas@glider.be>, Russell King <linux@armlinux.org.uk>, Will
 Deacon <will@kernel.org>, linux-pwm@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH v2] pwm: tidyup PWM menu for Renesas
Content-Type: text/plain; charset=US-ASCII
Date: Thu, 8 May 2025 23:39:58 +0000
X-ClientProxiedBy: TY4P286CA0004.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:26d::12) To TY3PR01MB10906.jpnprd01.prod.outlook.com
 (2603:1096:400:3af::14)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3PR01MB10906:EE_|OS7PR01MB11424:EE_
X-MS-Office365-Filtering-Correlation-Id: 84a8d9ac-18ca-470d-1919-08dd8e89a4e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/54B5QMueLB/Izo9FC3j02LvnCvTln0mM2O+hCQM6BvIKQ0hwlYiFCmWHUKA?=
 =?us-ascii?Q?pR91f16yBuCPaiX3gFx8hd1mzX3QwtU0AbNzpu9bDM+E7fa7EibzLFAgy0ib?=
 =?us-ascii?Q?uDeIj7iVgcF0oVp0G8CMiCpHHOGV0+G3KQtamn4qqT51oxBhi3CG9eD2Kyvz?=
 =?us-ascii?Q?sxLZ85flwxAD0109AniR1qTdlQeUTtZhBFdcXVnAogbReKku2+Lxc3Qg4b1D?=
 =?us-ascii?Q?sn8upsmIsrcw0R9Yq4Mc8EXIZ7D99griKPpRZNDDBf9TTfJ48pZg6Fhx5OhB?=
 =?us-ascii?Q?X3k/gjrzRk0a9ScIE0GVnw3Rs91f2jILWFGGhfLiN3NX1vJaSdtrjOldrW17?=
 =?us-ascii?Q?JENRC2iUxxA4YDcCYwKYPKCbW//qkPSuwd2Y3N4XGaNW1OYdcKmeeWIXomfm?=
 =?us-ascii?Q?E1mEeLjn2YVtvT29ujCcT+t3Ea8UdCQYfN+FYFiq3QYNBHiH5wR/vIGSAKRG?=
 =?us-ascii?Q?eEI1sl+qxzXdio2EPNt9XHsrkpMpUR1nYxZ3yltrHUcWKvNYek9trHouMfvW?=
 =?us-ascii?Q?KmGh0z43DV6YekT0WUIlXjCVn9fcn5+0xuvy3q1dzI3JlD5z09suITfkTcBV?=
 =?us-ascii?Q?I2G4rvqA3Oet1/k3PFrsxGjKqcFprjsJm/ydkvznI5hpDNXtn+j9WXI4RSHk?=
 =?us-ascii?Q?WBWv0yvNMSuIgnZx7gwLO/TGOpAC31t/E0XYKfHJYeGxCpPLhN4UyA6rh7kj?=
 =?us-ascii?Q?5hTO+1tfgfardlZWS5V4EVtr0DagRUgrsogOIAoW6DM0Lfn42j5XIN+LOpc0?=
 =?us-ascii?Q?K7FQOfiDQLg6dwF2uAl9/5D0APmKEtiqRx7cDOtNVwtMLWZpXFhvBq0JFZjB?=
 =?us-ascii?Q?IJGC4BM9dkOHZs466WMyymg567W8E4viwrI5I+p6QNOCXRQB0i4UNLUMwr99?=
 =?us-ascii?Q?Cn47XrjYpK9D7O+QJhhkOwD9dUhs/bEzOxkjBgXhk+IDuoBxP5ynib4tmbxy?=
 =?us-ascii?Q?yl2PPBT1gb8y51RZz3k3xCFOb7eRIRz8EsSnTtjxtai85Qja825QHjSAp2tY?=
 =?us-ascii?Q?wZfYFQyR3c46shF1p6FGcH0O05e9UBZqfcbhLXQgh1cr1YWZeGwxHbgwp7gW?=
 =?us-ascii?Q?PnuOyBuWU0yiei9IKZ4MFPim1MhOy/2CU82+fJR39Cq1qzszV8k3GyEX7Kqz?=
 =?us-ascii?Q?kHONUaQXTEANDBxaW7+fkcx8f9ClXFtCI4r7Oit/QuV9AysSGb7SNhE49Kk8?=
 =?us-ascii?Q?5ueWDjXxcCa2j877QxKBdbL47aSz9Vl/6BlPaHb7mld8bfqDwzaT8ySKUmjM?=
 =?us-ascii?Q?jcaaSVkgxDzV3j8lrfgYXTTWdVVQt6VSicmNvllln8foOq9vX1T3Lf+WVZ2t?=
 =?us-ascii?Q?YvkeuBbCch+BDPzEzsmLgxJczNv+c/TQB6BJcbJ6I1kZ36Xg9HY9dzLNU9Qh?=
 =?us-ascii?Q?8jMQREqkNace1hMVm5jjEftJ9Jf3uyWXmlPGCoje3PVeCoOw8euUm5qa4s1T?=
 =?us-ascii?Q?thrbPIDsb12XeM9blrS1v2k1pXy6sXuM3xZ6GzTQL8uLu4kRE+/geA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB10906.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IKvK/MGN0bpFPyNLXKdUNoXOh33OKU6tZPIou0RhKy8l4AaMzHdmNoe1NMb5?=
 =?us-ascii?Q?HP2wQpTlL/cLCL3c3tDztsw3J5Wi/9/SUZUP20k4Sp8WjjtJv0PU1tI/ldD9?=
 =?us-ascii?Q?K4tWFrBpUvcR441IpUpUWq/AMajIT6W42nwfmmTRkyFNTT6NAduJAa2tym53?=
 =?us-ascii?Q?55rdoT0CV7p/BedaV2z/MW9KRoSyxbovmv+hp8o1tblc7OZXLxg5kkAcUSHj?=
 =?us-ascii?Q?jDmg3ARQj/x6qjIsD4hLDtp8GUrJbzvnp2emwnD/cmH92To5YZLycOK7ASEm?=
 =?us-ascii?Q?x3s5dL0BIxc95L2ALoNw+2KFW3gCD01lHkIQbtWq2nAlqrMuQbQimCNtg3XU?=
 =?us-ascii?Q?v9xRRGMQ4V8BcwnG7kF5Cnxp+10kLjB52t7shBZBLhyvHae1jP/GOIlBiFV9?=
 =?us-ascii?Q?4HNzbnqGY58146GQUM01TfFtLrk9DfpniGGytQDQsvMLnlLyJIMFOqFUeRYL?=
 =?us-ascii?Q?eg2QmZSJ/I78faCQf8+56wk/wsPFWPq7WhMaUI9NZA7WqXD/r9hthou7uqP9?=
 =?us-ascii?Q?0H60oai1oZd6GLXJrFrtDadhqZHa+bBYk8aMGP4aG6HWp3VO2fbUx8xr6l/t?=
 =?us-ascii?Q?JD0lvPLs6BgGugAwlNZoUx2Em22fUoc4I++mJ+iNBkQcdY1fk64cH0JKOcwp?=
 =?us-ascii?Q?ZP5do9MQcaBYUe+vjDg3ohKXhPq+nYSz8GBul5S9vWC72ldL1o6nfGwkmHK8?=
 =?us-ascii?Q?+ooxw1OKk8uHCBd1vedalpj9EJK4byO0tfQlVZOES0P+9qofrM+DA45fHcCR?=
 =?us-ascii?Q?P6r7whQcMesgNLfiEhLVqqsIkXJydPe+yP82hqtb6TtIig8icMF5PGSt7EiX?=
 =?us-ascii?Q?WgVwCA06YiBxYRZX9+1I5trbvJ1U8lMaQZd1gb5rpYT5YWG5FzYKfyrFhcz1?=
 =?us-ascii?Q?ShA7kJnU6zZuAvVnCHjfTocpaqr8jKgTEyVPSXiJZ2r5nFLBBJdpED4XubCh?=
 =?us-ascii?Q?PpdfwZe1FZ3Wzk0XhPqmFGtxAEj20FZ3vWmW+ACqbWoLRwNTAKOTjJOL9MuF?=
 =?us-ascii?Q?dZImGcjA94kohCgF1sv2et4J2cd8ijhARbPw6BK6z13XjDszY4FUvD9dfYmt?=
 =?us-ascii?Q?fhrjTshcNDLpfuLyTYPNKmzxpn6248L9Mw8FnwJmu9MZm0xf0kp8BrCQhmhW?=
 =?us-ascii?Q?Iza5hvqzBd28bs7IBccR2TD7QpfZdda4yJIWYXZQgkG3l5b+X3joDlgdTanu?=
 =?us-ascii?Q?F/DmrD+jHRA0gQWrPxCsgUT05nPG4lb5zOAY81SfwJ5v0haY6hp64W/3knEM?=
 =?us-ascii?Q?Y1+ttjP/0BGVubYE2OJ0zr7WO5/XisQVxS/JCawL5OHIlpg79rAS6BtyIxhu?=
 =?us-ascii?Q?czQZeTIqH1oigLaMg2YA7ci/N0srtd2DIp+zjid4HI9pbcBBsTTnBo3bejhU?=
 =?us-ascii?Q?Gbem7AUpbdbKVhw+uVqBlKd1PsurLGV4+eGeySI04N+1/VjuCMxPN2u5caRD?=
 =?us-ascii?Q?hauOmb5jt9ApTztw2KAHW65r5+BLmZBp5aVMXX5pfygF8ab+LgGsFQMsnUzs?=
 =?us-ascii?Q?BrRUJfWjEJv8Bpl6dliPo0O9YWNTL/ufs81e8NFJFwqWpHr/t4YPfn7Zb5NU?=
 =?us-ascii?Q?9E30DDbbRuURc8UW+/WLLW4u19x2cR0j2ES+jUxrY5s1OZWImp3kWSDy1a8/?=
 =?us-ascii?Q?pYEYm2yLX428yQvn3+iuvdY=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84a8d9ac-18ca-470d-1919-08dd8e89a4e2
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB10906.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 23:39:58.6294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mla9CJSv2hFRy27oJjJdq8i3H3vpvihbNblZlCYQoXziLA/DQ03lNwil5ZQDFVrWhO/K7wLtvmXPpqu2MGyT0SfK1huSINiM2/DerudUe3R2tpuk7WkTqvSLAqjlULWs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11424

Because current PWM Kconfig is sorted by symbol name,
it looks strange ordering in menuconfig.

=>	[ ]   Renesas R-Car PWM support
=>	[ ]   Renesas TPU PWM support
	[ ]   Rockchip PWM support
=>	[ ]   Renesas RZ/G2L MTU3a PWM Timer support

Let's use common CONFIG_PWM_RENESAS_xxx symbol name for Renesas,
and sort it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/configs/multi_v7_defconfig |  2 +-
 arch/arm/configs/shmobile_defconfig |  2 +-
 arch/arm64/configs/defconfig        |  4 ++--
 drivers/pwm/Kconfig                 | 20 ++++++++++----------
 drivers/pwm/Makefile                |  4 ++--
 5 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 37e3baa33b678..8439b24f63534 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -1203,7 +1203,7 @@ CONFIG_PWM_BCM2835=y
 CONFIG_PWM_BRCMSTB=m
 CONFIG_PWM_FSL_FTM=m
 CONFIG_PWM_MESON=m
-CONFIG_PWM_RCAR=m
+CONFIG_PWM_RENESAS_RCAR=m
 CONFIG_PWM_RENESAS_TPU=y
 CONFIG_PWM_ROCKCHIP=m
 CONFIG_PWM_SAMSUNG=m
diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index fd28f3176c6ba..e4e69b381af15 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -216,7 +216,7 @@ CONFIG_ARCH_SH73A0=y
 CONFIG_IIO=y
 CONFIG_AK8975=y
 CONFIG_PWM=y
-CONFIG_PWM_RCAR=y
+CONFIG_PWM_RENESAS_RCAR=y
 CONFIG_PWM_RENESAS_TPU=y
 CONFIG_PHY_RCAR_GEN2=y
 CONFIG_PHY_RCAR_GEN3_USB2=y
diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 1f25423de3833..18d8c0825333d 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1537,10 +1537,10 @@ CONFIG_PWM_IMX27=m
 CONFIG_PWM_MESON=m
 CONFIG_PWM_MTK_DISP=m
 CONFIG_PWM_MEDIATEK=m
-CONFIG_PWM_RCAR=m
+CONFIG_PWM_RENESAS_RCAR=m
 CONFIG_PWM_RENESAS_TPU=m
+CONFIG_PWM_RENESAS_RZ_MTU3=m
 CONFIG_PWM_ROCKCHIP=y
-CONFIG_PWM_RZ_MTU3=m
 CONFIG_PWM_SAMSUNG=y
 CONFIG_PWM_SL28CPLD=m
 CONFIG_PWM_SUN4I=m
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 0915c1e7df16d..cd4a034061e77 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -510,7 +510,7 @@ config PWM_RASPBERRYPI_POE
 	  Enable Raspberry Pi firmware controller PWM bus used to control the
 	  official RPI PoE hat
 
-config PWM_RCAR
+config PWM_RENESAS_RCAR
 	tristate "Renesas R-Car PWM support"
 	depends on ARCH_RENESAS || COMPILE_TEST
 	depends on HAS_IOMEM
@@ -532,15 +532,7 @@ config PWM_RENESAS_TPU
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-renesas-tpu.
 
-config PWM_ROCKCHIP
-	tristate "Rockchip PWM support"
-	depends on ARCH_ROCKCHIP || COMPILE_TEST
-	depends on HAS_IOMEM
-	help
-	  Generic PWM framework driver for the PWM controller found on
-	  Rockchip SoCs.
-
-config PWM_RZ_MTU3
+config PWM_RENESAS_RZ_MTU3
 	tristate "Renesas RZ/G2L MTU3a PWM Timer support"
 	depends on RZ_MTU3
 	depends on HAS_IOMEM
@@ -551,6 +543,14 @@ config PWM_RZ_MTU3
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-rz-mtu3.
 
+config PWM_ROCKCHIP
+	tristate "Rockchip PWM support"
+	depends on ARCH_ROCKCHIP || COMPILE_TEST
+	depends on HAS_IOMEM
+	help
+	  Generic PWM framework driver for the PWM controller found on
+	  Rockchip SoCs.
+
 config PWM_SAMSUNG
 	tristate "Samsung PWM support"
 	depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 9081e0c0e9e09..b8ed6bf17cdbc 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -46,10 +46,10 @@ obj-$(CONFIG_PWM_OMAP_DMTIMER)	+= pwm-omap-dmtimer.o
 obj-$(CONFIG_PWM_PCA9685)	+= pwm-pca9685.o
 obj-$(CONFIG_PWM_PXA)		+= pwm-pxa.o
 obj-$(CONFIG_PWM_RASPBERRYPI_POE)	+= pwm-raspberrypi-poe.o
-obj-$(CONFIG_PWM_RCAR)		+= pwm-rcar.o
+obj-$(CONFIG_PWM_RENESAS_RCAR)	+= pwm-rcar.o
 obj-$(CONFIG_PWM_RENESAS_TPU)	+= pwm-renesas-tpu.o
+obj-$(CONFIG_PWM_RENESAS_RZ_MTU3)	+= pwm-rz-mtu3.o
 obj-$(CONFIG_PWM_ROCKCHIP)	+= pwm-rockchip.o
-obj-$(CONFIG_PWM_RZ_MTU3)	+= pwm-rz-mtu3.o
 obj-$(CONFIG_PWM_SAMSUNG)	+= pwm-samsung.o
 obj-$(CONFIG_PWM_SIFIVE)	+= pwm-sifive.o
 obj-$(CONFIG_PWM_SL28CPLD)	+= pwm-sl28cpld.o
-- 
2.43.0


