Return-Path: <linux-pwm+bounces-5883-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D19F5AB2C7C
	for <lists+linux-pwm@lfdr.de>; Mon, 12 May 2025 02:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38B841890722
	for <lists+linux-pwm@lfdr.de>; Mon, 12 May 2025 00:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E0F2D7BF;
	Mon, 12 May 2025 00:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="O+9KV36q"
X-Original-To: linux-pwm@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010064.outbound.protection.outlook.com [52.101.229.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EC7125D6;
	Mon, 12 May 2025 00:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747008039; cv=fail; b=DxOca+fL0nf7TZTCQ+R4gcUclt7surZ/903+c67jXVhBGWS+FwS43l7SfSnDUngqMUE0NhwDBCgvoXySAte4Wv/0aC0fSAjgLjh4vCd6z1Xu6nh5+z9+9o/NyaILG/WH2+9CIXjOMprpabABKrmWnnAH2hdvouCnuS8SOImeI7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747008039; c=relaxed/simple;
	bh=YZPQ5Odumok4hLTAdYPJith/mv/jA7Tg2vwxumcwBQ4=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=Cjx/agsdBaRgYlBAMLtcnDa89/i/Nu7fxZDhP8noY+wfAe5I2CiPjm6jrj2UwUxHqQxneQQm6o9H3c1/MUkZIcY8Zxxw1krh0wkBDmXecBLp/VR6AIFnmYJT4X9DuIZMHGFjDOt9B4FPuTIgsxev3eWp3scd+OZgCTFvU+5oYqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=O+9KV36q; arc=fail smtp.client-ip=52.101.229.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SHc8RrF82kkSaA8UUQ0Jx3IjjMQS0Y60C6EHOcZHjC55ukPYBwdy7QGWWapgI82UIscfnUgFsSTNBNpbCItLoa5Qkoe/HJcv1Kt+Gkm+9indopFkL7zpuHW2bG6UvOKD2GcShH0rxSA3kZfO9TomRRgZCYbEtWE5fabY+0q377Q5eSLc3axM0irNoNsuTAfMl1MBQpAV/biU5iG6b6FadF9RBkoLYTjrmmCD9+a+sChYJ7Zf5fGTBe3wYaF6rFvgzDevkafhhhgPKM7uqSRX39ly78cPJas42+Knw4ZEPkWi+xvBQidlnVsPqDUlDQxy0I2X5RJpDOz0UVKr8Jw8lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZPQ5Odumok4hLTAdYPJith/mv/jA7Tg2vwxumcwBQ4=;
 b=EKFRaTnCnHvJFx0B64n7UWIL0flV2yVXE9yssnMHZZgOTOq535VPwlBs1k/EK+LmuGts0UAveTLGsRhKdWEykhkvKxzG7g59Q53b02YAfPZ9+QH3nhL2Ce7V+jzlsUrN5n5IyY39/pP51DKR3aymC81kBFGBZV0mjkHS1kKN7NRSY08lOKpxXdagX/VurJm+HHGAIZQpRtVgJlTYUd0jHLhJ81IVJnjz+qf/9s8tymO+Tu86SiIC2SXDfKcPVFx+DYveSrcJlKy91IQlC46SLGlVhixU07c+lxblnCZKsVS+u8dtP9l5VIq5pO80PEO0l9FDmPiXF49S0/3bUCSj4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZPQ5Odumok4hLTAdYPJith/mv/jA7Tg2vwxumcwBQ4=;
 b=O+9KV36qXHiktioH7b/+WVBvncRbR7iw5j6Rj0SHMJnTOMeDHx7L8jDe8J2zpjofq6ISSTtsKgQ1IEmfHjDDnb5TKAUHOuHfiHhgvUeiafAHYTm/d8/btv9/+tsqSK+uDH0vIcLISmoKfg13cUbjsiB/l6eIxewoItiJwCxzWgc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by OS7PR01MB13738.jpnprd01.prod.outlook.com
 (2603:1096:604:35a::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.26; Mon, 12 May
 2025 00:00:32 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%5]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 00:00:32 +0000
Message-ID: <87wmamy9y8.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Russell King <linux@armlinux.org.uk>,
	Will Deacon <will@kernel.org>,
	linux-pwm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2] pwm: tidyup PWM menu for Renesas
In-Reply-To: <7vsimju2qa5oa7bnvkqhopmx7dmto5luxz6jjugdwiifa6nhyp@sz7gff3egqps>
References: <87r00ypt81.wl-kuninori.morimoto.gx@renesas.com>
	<7vsimju2qa5oa7bnvkqhopmx7dmto5luxz6jjugdwiifa6nhyp@sz7gff3egqps>
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Mon, 12 May 2025 00:00:32 +0000
X-ClientProxiedBy: TYCPR01CA0135.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::15) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|OS7PR01MB13738:EE_
X-MS-Office365-Filtering-Correlation-Id: e286f690-d0e5-4dc0-c885-08dd90e80374
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xfXrnRzJGf+IWQq5qKP4uCH1yjNAK9HUnDgHAFxw2+OOyIi6CqOGurJa/nbU?=
 =?us-ascii?Q?RBuNSniQWecfkt1zEOZ/RLB6lBWtstt7+KHhl0ca1vUiXIR8AQdXyBTggrMB?=
 =?us-ascii?Q?nx4odpczDZHkTCvcZwqXN0fxImG0lHYniWaF6qK5VJxn2/XzmABmUChAOYxu?=
 =?us-ascii?Q?YutUEaediJAOWsf2LX5Js6mFeKxLVFnPiWD512QrrisIEprQYk8JBnrHpU6J?=
 =?us-ascii?Q?dgErPAvk5iIGumapirMmPr+Hj2OETFbY9XOvbS6hH7JZ/xLDiR8vqS624d6q?=
 =?us-ascii?Q?Ax8NIZreDxFvNHKs1i9iwNyX1hnzccR609yBzvd2aVnJdjq/ECHx1OkicKZc?=
 =?us-ascii?Q?rGsV7SLR7Kdec9wVLH7/ODJv9NI/yq5qkruKaBpet+JC5tOFrwEo5n/rKkso?=
 =?us-ascii?Q?7ITOID9GcX92uMfqX09bD0d7wNECCG6uyQH3DiHsiHym7ZyDn8OvDxz6uMyd?=
 =?us-ascii?Q?dpc+nnBO86gRkWxg2QqQgcnn+7ujV5eMIAbvVh7d7HgPKOircPI3jppkeH6p?=
 =?us-ascii?Q?If2J17bK7vVYUuhm1K4cKeHlcl+pcsL//3cvc1PwHyYklm5v/uktdPLTX8sl?=
 =?us-ascii?Q?64d9l+upY0fDTAr3mFTIrhLsj6znCzH8av2n5XUErPlE+pDQjjTPgutx7IXg?=
 =?us-ascii?Q?clfLLGqv+8SWHgrXQYBQDTuHvnSlaQklIlLyhnWjYvw2Q+ntnO3SC2yToDy2?=
 =?us-ascii?Q?1UUmvE/Ms/T0tlBE5jTF1M6oi9wTo3p9hFdVjdHnabVcczZVh5HiH7UjxU+A?=
 =?us-ascii?Q?rDUDeG6072AlXp7Wu2BVgjyW6DOWeTt4Zvag6L/VQNWsm1IFc2ltZZuXjiEr?=
 =?us-ascii?Q?5Ncz4JGsD5mO7AWgXW2xsH3zwXJZkflIXf0ObEB9CkHp+giGe9qh/YgUSyaB?=
 =?us-ascii?Q?V1EkOWlXHUr4r0zv8j9HrtCif3DxGGS/aeTR5xV1+BbVcDI9cl+JLoHZ4l1q?=
 =?us-ascii?Q?3DDrwusN47j+Nf7EBWUaSm3yVAYTXDKRYkId5oyC9crWRsD8DGlp0kh3fPrk?=
 =?us-ascii?Q?+R0gvV4SUGzmvs+bmjIaFOeyJETJhMJkOsZ0Q7cgRhRnMLMYNAmvQrJayTzW?=
 =?us-ascii?Q?iHZJFmmDX9jYKQiQ+peTNsIFy3qJwQx+7VboEWoVqzCuwO2K0K8WMfdhCIMm?=
 =?us-ascii?Q?iWDwIbqYjfUT/+DlRH/4GZYfjqccv/fouNriNNIGehC/ekCqz2hy1VUaYALO?=
 =?us-ascii?Q?1hX6QDIfiAtUY+5+rtCoESbYCp+EG+Lacv+Uuj6umMw8J+Sd8nn2o2+K4pWJ?=
 =?us-ascii?Q?wuySMfkp2nxFYBri7Tam6rMMFjbMQAVkNDSN86SCMsdXLs38Jz+nfCWT9aXc?=
 =?us-ascii?Q?diwA+KVgVmtm+I3cbPGmk8YLto3owVHzE4ofq3vtaZ3dZMVGfUXoGmGpOepl?=
 =?us-ascii?Q?DV8TpoTl4mM+7vw0ZC8+Bd8NESVcu6tqpW/R3KDaDqnccrJ767UCiuWReT9f?=
 =?us-ascii?Q?kVe1GhhB/GQm2+e+E8RNxpPa2BQmNGv3j5PlKQdE99b1ObWnBkcJng=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dZ+0JJm3E6mrPAGQFk7WA9KbsyRW14FW+pc4zoqwhPvamGm0HSb2gPqVPBfT?=
 =?us-ascii?Q?MlY05c/OsuspYYEQcFPWH+7jKNSro4z9vdsEJConxGLscLngCpgejHW5TZWm?=
 =?us-ascii?Q?EEig+L1p21adp525XFwBCUKuDi78tnHn0AWdxlz5fumTNe1BdUeNlCfep9yc?=
 =?us-ascii?Q?3GmydbZxJF7USic/PtU48xSJeNFFFtFoem3F6j3UElxXLqKb+QlJiSEojUvO?=
 =?us-ascii?Q?2yrkgBo4ZhX05nbK7q+Gzd1+ytFrjJJdd9v0PZiHAVSuj+jEu5j2MfifI1Be?=
 =?us-ascii?Q?kA9tkTOKqP9USpK2pSPzHpo3aevnZdfp+kEMpvwukoWGzUTlBH/hnZsb+rMx?=
 =?us-ascii?Q?cTPyYDnf5uV7QA7vt6OE4QihDPUD0MnuRqiMdyqXCyyECCU/B6K/YfKEBjb/?=
 =?us-ascii?Q?BVaQeXXm7fd/cFmOliSd50OU4oVGnN3d5jpN/+sywsdnORXBRUzfyQEtW4bV?=
 =?us-ascii?Q?nHV2/bYu0VSIzIC9TbuDiE5kTfMnUfYivS38ZNiswAElmlhgXQJeGg4ujXWc?=
 =?us-ascii?Q?EATMF/5ztgr9dm+7los4CGnAjXirk38GeDZ7sPrV5Asv9kuIL4PspiN6dijT?=
 =?us-ascii?Q?wtS1AmwGa+L4I+TQ2OQAHc6ssLc1y2tcHw5jgaH4k0qxi52rS+ZLCr1A9TYJ?=
 =?us-ascii?Q?Q8x4y+pY77AJc6cSIX2pg9WIS2IjM+LSYVut/7bZbdzp5DjEmImDXPbAgBzi?=
 =?us-ascii?Q?eV9UCdfvJCO2FB7by6pa0GBr0ISf4F5xyTsjTuxcJ0C0hMl2DGv3bk7f8MoQ?=
 =?us-ascii?Q?tUXg77BHKiuwBMsAmwIicb/wHKdSLb+kQROjICy37ZFY+K9/F3AAxZIXozra?=
 =?us-ascii?Q?f3knbQL41a8jX+YzDAMiIAMmE2qfe8FFGDvx5JNau2almVA5I6jyRmcMqg+x?=
 =?us-ascii?Q?LZrdcXKlkNPWv2b5dDfJjrsxNxhg3bGkTlD0TMY/dzxMNFPm6Q3k1XyMDeBh?=
 =?us-ascii?Q?FHKakhVbgghAoZ0UkgXXPPHTbMgmleKisX7l7UP/BiDjp8kh558I1B+N5Uos?=
 =?us-ascii?Q?iEQjW11kCKzlKH8LJOO7TgsxK5Agb8FmrQSg/nbAHjfFjpxuvqfItvKw0eOQ?=
 =?us-ascii?Q?8Db2Swl9RdJb+kTlvhVxI8pf1AB9Wnu5eEAAW/3H/AQ/a053EpSuyYfY54Lt?=
 =?us-ascii?Q?HdkX/wflBrTD4h3fDG5fUXKdgMvCMiD+J8HFeUVi4jR0oh5IP0jug0I8bQ8a?=
 =?us-ascii?Q?tLea3/wCVz2O5Qcg4eOJf0cKsunax3scbZ8oDkrPNQz/xY8NGtjLHYBgjEpV?=
 =?us-ascii?Q?TS3y8tBQRu/zwuu6E/cVKx8EaZYvGtsyBC8IC8Asvf7S94+ZaDMgD/a5oXe8?=
 =?us-ascii?Q?xdWeAqrmzPEVf//GzUV6QIrTEPGsjsOuH3A5AwxC9CexLlqq8WE91cscpXqG?=
 =?us-ascii?Q?3KQa7RT3cCOow8Z+BRVtQ+gRtg3dTFe2NdpGon52cP59K9mdNl7/4RyX675z?=
 =?us-ascii?Q?tAuHYG352IrfkQLJHlUtc8JNAdy0FuKcDVejSmyOaRdaiZLzyVuStmZSkWq/?=
 =?us-ascii?Q?iKOtob/e9vp1DH00dvOvgLeUwj/bejEcI2C3o9uUSaErfAA02P7KtX1clXnM?=
 =?us-ascii?Q?AXP0Lu+vFvUGCLycXpQuGTuKg0wKY5JDF/Fm9xilWqhApYTQp1wUb1Omo/Oo?=
 =?us-ascii?Q?oEVuK54c1H8L/I64TEWIAtE=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e286f690-d0e5-4dc0-c885-08dd90e80374
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 00:00:32.3198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OL99lfTEUYDtPgNC/lwN6j1wq4mP34l9tvauVWIC3kAl8jI0bNdNQoLc2aZxsBQsdQ8GcgP/P8tOtPRmGUrafShujnJIZ8C6BSOcrRuinWGbnJMuNOSUz0sasgD8uSni
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB13738


Hi Uwe

> I like this change much better, just one comment below:
(snip)
> PWM_RENESAS_RZ_MTU3 sorts before PWM_RENESAS_TPU.

Oops, indeed.
Will fix in v3

Thank you for your help !!

Best regards
---
Kuninori Morimoto

