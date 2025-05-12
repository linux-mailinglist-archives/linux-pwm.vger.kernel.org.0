Return-Path: <linux-pwm+bounces-5884-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B886AB2CA1
	for <lists+linux-pwm@lfdr.de>; Mon, 12 May 2025 02:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B32E189206B
	for <lists+linux-pwm@lfdr.de>; Mon, 12 May 2025 00:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D550D383;
	Mon, 12 May 2025 00:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="gsLNuXbk"
X-Original-To: linux-pwm@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010034.outbound.protection.outlook.com [52.101.229.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A507632;
	Mon, 12 May 2025 00:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747008473; cv=fail; b=KIkGx5lEEmRkve+2hOUoTuYvXX/RO70e1FubijX8seZrr84xj6yoHFh6nxyQyGbETyOyAWH7x61JTM/32B/gH3RTy+vfYH0WjE0jHjdOqOvft5l48fgyLt4mPvjAYRviCn6/xaGGc1doT+4NkZZxn134M7yu6sJOSdDg+bqqaHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747008473; c=relaxed/simple;
	bh=twz5uxc7GRM4lXj11mUWsmtzHFxw6iOqixg44b2l2gc=;
	h=Message-ID:To:From:Subject:Content-Type:Date:MIME-Version; b=oXrOhcD1q8pGTpAChnTYCDnsWteqAXVnpLkz5sBJAXlXNgBVln1p/MBS0Qj2Ktgrl65sGFmU6qcjGUu4qmT0nldsxp014VlGhhzXnh8NrdIDKl4E4Xi2xkg9qID80lg2E5AVkZODk1mYv5PV/6w8U1G8TxJK7ZYkAXWTz6P7fRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=gsLNuXbk; arc=fail smtp.client-ip=52.101.229.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EQfulySGQfOQgL6O+JNA3X7645nBGfMtYesPYPDh8DgQ97q2FBELDd7+YLgYBewbliZ3+9SaqZd0gTyRXs5dBArj5Psz3Xwqpk1YUgvhW9HRK/rvd4EBDlISFg6esSmkGthIXk20OLk+RIA4GnTizGKCyQ8Meg/roNM0sEeVNx43eON0SGCBUsBuVHGldZk7kDU965jhgQ1zwB3ufrbL8HMSvPsuZGoboL7hnRbNe2kmRv8Yo0N7x5rJ+rCEYliXriPyb0MIdwNkCaq0VcdqUj5UldGDoEH6Z8h8amHqSwZH/ijo+OSrCryn8FsWvytF4DBB8n/lfPGPfIfI482gqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6GQoFj7r/APiTMfhH7Mtyaw3dmwwwkmUhg7sstiGuZc=;
 b=Us3IvvJXi2xnu6P2gixk062jv38cShI/JZW4yvhT6uSt058ha+RAMgNFf7R83CD5afCsg2tibDsWcWC278HBY+2gKGH05PzvM6OzfriAvs/RrRhIBiM4rUTZyFr6L084HemsPlR5l+BmABoeJYU7k1xCv7wg2yWksVpryMY27fyj2Nz661t0F1mbrmljFNdn3kFLxtpQ3PbEIF4ZiJn6zEo748V+qr+Dv7OE+wwis2iPozZBjAgqXuM2Oh8PM5stmQ198XAIicO2Xq7Maq3u4md/zA6Yf3u9fOonf3P8l6elj6NJDtlv/lKQ+YeAvANnqkMAsXU3Yk0ved8ANXaYig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6GQoFj7r/APiTMfhH7Mtyaw3dmwwwkmUhg7sstiGuZc=;
 b=gsLNuXbkstSqnsy2/es+FGO9srQ4S0XV0/wLc5CumLYxUI3wpME7HBfgiuIxsk22l8Dv1Ch6HAKtm6pWkggsxE65oNVKGXZ+iz0hq9d6aWtDgWstGBI+YcpkgH/MHsmSmNZwJhPq2rVjpS/Fv7CYS9G7jk1yWlaRK6UTqtbM7bU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TY3PR01MB11994.jpnprd01.prod.outlook.com
 (2603:1096:400:3dc::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 00:07:47 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%5]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 00:07:47 +0000
Message-ID: <87v7q6y9m4.wl-kuninori.morimoto.gx@renesas.com>
To: =?ISO-8859-1?Q?=22Uwe_Kleine-K=F6nig=22?= <ukleinek@kernel.org>, Catalin
 Marinas <catalin.marinas@arm.com>, Geert Uytterhoeven
 <geert+renesas@glider.be>, Russell King <linux@armlinux.org.uk>, Will
 Deacon <will@kernel.org>, linux-pwm@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH v3] pwm: tidyup PWM menu for Renesas
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Mon, 12 May 2025 00:07:47 +0000
X-ClientProxiedBy: TYCP286CA0115.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::19) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TY3PR01MB11994:EE_
X-MS-Office365-Filtering-Correlation-Id: 9973a265-2668-4550-38d7-08dd90e906fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kvzM8nIIE0mb6Hd11hyiVfBylOGmqym6sDxk776e0nN8tTUWOldprzIqLkvi?=
 =?us-ascii?Q?B9dv1Xkb4RQQLBWDWbIw39CBmhyEKDKy8L5pX2XzrCW8GyWfSu7xV1Y8Y6KS?=
 =?us-ascii?Q?9TlzW4GEJm9oCbtg+bKRVP6pBniTibcrhdAgwMJLdJzS1LT/Hkryu4ke9q4q?=
 =?us-ascii?Q?2WIyCHQsDnEdWnv01EspUwYNm57y6rK9cEjyKTvm6XDQgS/aZqZiztaZgtzP?=
 =?us-ascii?Q?ElMozDzc4g5oM5KwT9MXb6D9FU640+EKYmpYazdy4SJKgAj8HU50kmgGsgM9?=
 =?us-ascii?Q?DglaveGVXlO9WclyPIGesjkVEs/4w6rZI7d944HjmYzKaX1n0524dyVtvxAu?=
 =?us-ascii?Q?p+jU8ePFMhOU8lK+ivQzWyWiumzlg5uZLOwpL3t+x+z13fMfvGWPFxj78rEH?=
 =?us-ascii?Q?VOYHQJHPcpzDMlCsGP0OS+Z8e7gFlCwwl5m3SsPGs3nLONCRtmTo/XGCnVNK?=
 =?us-ascii?Q?nwGQ8mXV+osZFiJEN9m+tP2SmTqWmaoqikxwulhjolQ763k0b7MV/5wpX7fQ?=
 =?us-ascii?Q?9Yv99NzSc0F9j2nAUyhhG6c4ATHiuUZa9TZWhZvwHIFA4RkNGh0CCpmqXguS?=
 =?us-ascii?Q?/UtVQ1V8Fhg4pmTTJgYeMTAsz8SDPwqm94Lv9zY9bv90ed2bd4Z95mtXd6ba?=
 =?us-ascii?Q?eDQXV6kUOphxuxL+FPXKQgqM/Rr2Yd+gP790KQxzGvQ4Lj7YfW9I1JdIeuVl?=
 =?us-ascii?Q?MfAHCA5ZOAIpr0Ay6jT4oaifnSpl5vuBNxUNPePuDcAgItakgMS9Ud/H8X0P?=
 =?us-ascii?Q?nc6kVtbogIYv8l3wxdC4RrWiNGquf6evrHmzzxAVWQP0szgxFXtdQLltES0s?=
 =?us-ascii?Q?dYknMzo3sZVo7PunwsJOOgADF+CN1ZeJ7TQ1LEvV0XlDoiv2kgTO4nh24FAR?=
 =?us-ascii?Q?f7IVmCA8Z+lg9iE+BnsPdopKqnyNzJk/McdbLf7ddib5CFxzYkrZAV+jUauR?=
 =?us-ascii?Q?kH7etZKjwJy5Jn6QFrkq9BQrpfhY4P2ulWalhYnqN8EyuYl6eU/3bZfwd4uR?=
 =?us-ascii?Q?olmEyi+bgH8ZXabnydk1zRWgZwOk0lWfIJeuTJEhTURXIOaEp1opaDegFSwn?=
 =?us-ascii?Q?flUPpV8+2VHxC1++CKRTTX+ApeiV/0UShX8OYqwvxFHL4OpQZOCMhHkTxGqI?=
 =?us-ascii?Q?q4CNA/TBQO9s7ekbQbvSDtfZN2LGLbYmZjFywdtMHP9EziIOgt4q5fgkLJkQ?=
 =?us-ascii?Q?990yL3kltiAol2bJCDibsw4vEpxKytXONPsdZ8Mg0UoFxkKRXsC71yvnC4P0?=
 =?us-ascii?Q?McS+2upUF8sPANTLG4/q3Ys/7iQh5MfORSsV0HIBpAZhw235/qTZB2WxqVHP?=
 =?us-ascii?Q?gokZRYL3/Ys6jRhi3N3X4dgazjwXkLnb+q4jcji80kTEA7dE3ZenIY6WVHp7?=
 =?us-ascii?Q?yY9rnxFa4G3V+YbCR+xl/c8UMNIFIQQ4bi1QpSYNw/fvvSuu3hY0w6TGH1PV?=
 =?us-ascii?Q?/N5lzSIxe9rJDlFc077/Ef0qExMFHegkgDl9zPZ9cKb9RBT9W/xKVA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/d12DVPgnslL3dxBYbPjNqJreuD8qnkpMlqXVIoERikHx5VhMYMcM/yh7DTh?=
 =?us-ascii?Q?23jcgeteWOo1F8bY2ASHScOHh1THLphv4vySRGYC02o4W7mwhjkmcz1V4e4Q?=
 =?us-ascii?Q?PcABxunjDgZKXaubLC+3poDQSPyy0ZZkVypldCb5X60Lnc6ms9wLgACGJAW/?=
 =?us-ascii?Q?42pGlko0EpwHEpIw99e7N/yZd76mDM+qV10fEZLVrAV2Tgo61HRMmcvRLvUb?=
 =?us-ascii?Q?fPv9g+hJqK5Ai2IX+P3FGQUkANu3bAYrHptHDAlQpGcV+o7oV4ldmiIpCKTy?=
 =?us-ascii?Q?2AicWl7GvkkTy8o64DqL5RBilK86cpa9VvaltR1kMyJPJC3TrFg3aLVpeLso?=
 =?us-ascii?Q?pl7CuNzJhOmHy1nrAsgu9gEw90tHhsFHQUoWewnf98xwn+04YJYUn+o1x5Rp?=
 =?us-ascii?Q?cnausXs5sehkJxYCI7ynTjtuk+FtqIvkvbYLo7vs9RnI9qDB9qd+41uogAdj?=
 =?us-ascii?Q?O05n+H6QPTCzbYuCuAX9PWFMCBrBxFMUJj3TdY5CGUqrKQlAHZHbhNTc71hj?=
 =?us-ascii?Q?nFKKfBN7nqDxMO9D04M80CaINy2ZCPSWsecRl3E/0FCHWgIaeVKkpAq8ifhr?=
 =?us-ascii?Q?+/MML2ZdeRDmQlKgPdCKuUIoSPJPa/v+iCicsxWtT11iUboYJIZMfZ3h6z4v?=
 =?us-ascii?Q?TS/uOVxSVSoxgbmi0C1/YV8DXwf0EYCIJv0+desGuAdtuDSshw3cHDal4UN5?=
 =?us-ascii?Q?g9E9XidQR7Y18gVkimKMknDnW6UX0LMjFhbqH9uSIb/tX8JP+7su6Q9L8XGk?=
 =?us-ascii?Q?KeAuX/rqEiwbaR+n5oQVT88uQb2C6UE3qog7/Go3OUc3/YcPkddW3N2IG4HB?=
 =?us-ascii?Q?IHyO9qb0hM1YgLSE1DaaPPlIY3+UJuZFRFUVYQDUdGcqSirWJotyl5ctBb5C?=
 =?us-ascii?Q?cKqmBU/SuLGztM3RTC9IDHyViHqfxfnp7iZKPbh7j7vHbAlvjSX1n9GpKzt6?=
 =?us-ascii?Q?Eq5Nc3JZyWnr426WEaXcFIC0zYkVbX7k/U+woy+S6NXPkL3jPie9u8sBWoTH?=
 =?us-ascii?Q?nTOnnWay3XE8QZ1YGcztIPxrxIwyD2ssCXYHc2jfue3RrDXCjbmyU9UI8kJO?=
 =?us-ascii?Q?a+OgyGK0gl2LyDYY6ELVHaz0mfWAFAMPMBDA2T045gCIiN6FoBHiRBs6/RS/?=
 =?us-ascii?Q?ghoYMFlgpJ/g5YWA5CPlJtzpJs3HnsiY5e768B89emmj/5iuQQd1juqTtNiq?=
 =?us-ascii?Q?L267El8IuDZ9efaYNe/UXgiPm4G62K6+liL7pgGfIItvwsecLHfqz2ySOE7S?=
 =?us-ascii?Q?GI0yaWvO1rjFYlFA4VaYFyAmebeqm+LbZg4TgYpFiulSSRORIT4YXPfJbb/7?=
 =?us-ascii?Q?I1wdXrnIF5OrXC38u8WjJ6beqs+VNzrfehDg0+/YVfMoL8UYybGctef1bh9i?=
 =?us-ascii?Q?fMPL3v6fjSrfGWk9wbtIOTsCpO76x3L4vHCkxxqaIm7b9U0vcGJRINBSx28z?=
 =?us-ascii?Q?thky6+s+SGlAWDNFyaTexinwNMsW849mwlpF8ZMIAaYcMX5Uz7VsUiGJmcgH?=
 =?us-ascii?Q?sdoo/0wGMYZyqxM0VmUAwW6sXLWFiv9BBTtvq6RYfuD3s7S2o3szmuqhwOGD?=
 =?us-ascii?Q?Z2661W4qkZilgV/8jkc6RSnpfUoMFy/vpa0LUOzGWyY415hTmiBw35azN3Cs?=
 =?us-ascii?Q?X0p8w+qa4/AHlk0VSIPwwYQ=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9973a265-2668-4550-38d7-08dd90e906fe
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 00:07:47.6970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oy3d5KqYDYW+HEMS7+cKKI4l/nAxmbflIscPxmjHq8obh1w2UeptR3Dnx2XzjxiwwAEz/BCtbsV/Mz8vx6XO0caMYuPHyge9C7p9WUFI+tG2md0JpExMP0y+TewDap7A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11994

Because current PWM Kconfig is sorting by symbol name,
it looks strange ordering in menuconfig.

=>	[ ]   Renesas R-Car PWM support
=>	[ ]   Renesas TPU PWM support
	[ ]   Rockchip PWM support
=>	[ ]   Renesas RZ/G2L MTU3a PWM Timer support

Let's use common CONFIG_PWM_RENESAS_xxx symbol name for Renesas,
and sort it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v2 -> v3
	- tidyup sorting

 arch/arm/configs/multi_v7_defconfig |  2 +-
 arch/arm/configs/shmobile_defconfig |  2 +-
 arch/arm64/configs/defconfig        |  4 ++--
 drivers/pwm/Kconfig                 | 24 ++++++++++++------------
 drivers/pwm/Makefile                |  4 ++--
 5 files changed, 18 insertions(+), 18 deletions(-)

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
index 1f25423de3833..1a5d30a1bc481 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1537,10 +1537,10 @@ CONFIG_PWM_IMX27=m
 CONFIG_PWM_MESON=m
 CONFIG_PWM_MTK_DISP=m
 CONFIG_PWM_MEDIATEK=m
-CONFIG_PWM_RCAR=m
+CONFIG_PWM_RENESAS_RCAR=m
+CONFIG_PWM_RENESAS_RZ_MTU3=m
 CONFIG_PWM_RENESAS_TPU=m
 CONFIG_PWM_ROCKCHIP=y
-CONFIG_PWM_RZ_MTU3=m
 CONFIG_PWM_SAMSUNG=y
 CONFIG_PWM_SL28CPLD=m
 CONFIG_PWM_SUN4I=m
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 0915c1e7df16d..a1000b48886d8 100644
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
@@ -521,6 +521,17 @@ config PWM_RCAR
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-rcar.
 
+config PWM_RENESAS_RZ_MTU3
+	tristate "Renesas RZ/G2L MTU3a PWM Timer support"
+	depends on RZ_MTU3
+	depends on HAS_IOMEM
+	help
+	  This driver exposes the MTU3a PWM Timer controller found in Renesas
+	  RZ/G2L like chips through the PWM API.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-rz-mtu3.
+
 config PWM_RENESAS_TPU
 	tristate "Renesas TPU PWM support"
 	depends on ARCH_RENESAS || COMPILE_TEST
@@ -540,17 +551,6 @@ config PWM_ROCKCHIP
 	  Generic PWM framework driver for the PWM controller found on
 	  Rockchip SoCs.
 
-config PWM_RZ_MTU3
-	tristate "Renesas RZ/G2L MTU3a PWM Timer support"
-	depends on RZ_MTU3
-	depends on HAS_IOMEM
-	help
-	  This driver exposes the MTU3a PWM Timer controller found in Renesas
-	  RZ/G2L like chips through the PWM API.
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called pwm-rz-mtu3.
-
 config PWM_SAMSUNG
 	tristate "Samsung PWM support"
 	depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 9081e0c0e9e09..a44e5c0ff135e 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -46,10 +46,10 @@ obj-$(CONFIG_PWM_OMAP_DMTIMER)	+= pwm-omap-dmtimer.o
 obj-$(CONFIG_PWM_PCA9685)	+= pwm-pca9685.o
 obj-$(CONFIG_PWM_PXA)		+= pwm-pxa.o
 obj-$(CONFIG_PWM_RASPBERRYPI_POE)	+= pwm-raspberrypi-poe.o
-obj-$(CONFIG_PWM_RCAR)		+= pwm-rcar.o
+obj-$(CONFIG_PWM_RENESAS_RCAR)	+= pwm-rcar.o
+obj-$(CONFIG_PWM_RENESAS_RZ_MTU3)	+= pwm-rz-mtu3.o
 obj-$(CONFIG_PWM_RENESAS_TPU)	+= pwm-renesas-tpu.o
 obj-$(CONFIG_PWM_ROCKCHIP)	+= pwm-rockchip.o
-obj-$(CONFIG_PWM_RZ_MTU3)	+= pwm-rz-mtu3.o
 obj-$(CONFIG_PWM_SAMSUNG)	+= pwm-samsung.o
 obj-$(CONFIG_PWM_SIFIVE)	+= pwm-sifive.o
 obj-$(CONFIG_PWM_SL28CPLD)	+= pwm-sl28cpld.o
-- 
2.43.0


