Return-Path: <linux-pwm+bounces-5850-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65463AB069F
	for <lists+linux-pwm@lfdr.de>; Fri,  9 May 2025 01:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18F1F9852BA
	for <lists+linux-pwm@lfdr.de>; Thu,  8 May 2025 23:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86AB5227EBB;
	Thu,  8 May 2025 23:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="dnNswn6J"
X-Original-To: linux-pwm@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010037.outbound.protection.outlook.com [52.101.229.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBB72153ED
	for <linux-pwm@vger.kernel.org>; Thu,  8 May 2025 23:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746747382; cv=fail; b=WyacQOmIwkIyhzCleAXm3+tLU8afRj2WOwfW7nvriS107eG9CMPLcW4QmpdA/O3sS9UNfyr4kr0CLu0OkgTE41J66PPLbTfh+rVtl45h955gPCNDvd8ZTXMgYJA1qwsPfVJLRGHXVa7YbuLtJJ9Lw8J8CIASKQZfyVIZZARgaj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746747382; c=relaxed/simple;
	bh=Ta9HoBrY8NVv9sbp7eKFY/TXT7qRM+jBuumFteSTxw0=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=ofKhyII5UufOWqdLSue4LxrJFR6ShX+/EWvVpJNXGVjTxM3EAJGfUQHXlnGuzrhOQZcSYfl8qLfDDTtc49eW4h1d1wrb8SiT+7Hbl3mSH0+3zXwn65urrr4vR4z1LpuBQ0MED5T9l6Pu6Az2PGxtPKvAGtK662/j7wOO9xufTPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=dnNswn6J; arc=fail smtp.client-ip=52.101.229.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rvn+JkLtPnBrYt+qo+XCm9YM3PnNz5azWwsQaarOZLTCBbsWbsYyO048qTbbi66X4zLNS1Rivi7VVQzuH3IEkQbwGTHNqfG/Ol3M+kccI6UaPbSC/d1rUMkIZWjmYAbZKHNIJMhTTM+UPQJ+cqqLXW0LfqqhE+psp5xc3DkDyh8P6BzwlEVeMI6wJwJHIh1wFxrdIldHNB7ZegXlAfPHpX7NYc3YmZ0/SEr3k9b97rhsbMXHAZIhp11nXJWlm9WxoXSihvZR0wetOt8w4W2drCI++3ni7xsH3zC9/b56XbNARgAiVmyx038KZu3I/AiDfDEfShntQQ8IC0NrSag10w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPA1Ct6hmAmJnTAy11hc1aBS77a4XFoz+vneplZWWQo=;
 b=bySls7cag6VkmiLW7EovEj2Uw0AJ2wvOOA/DT1wNVinUoUkOqfbBZf+tc0TelQDVnMfa7/xKtQOZgTPC3O7Q3+pqClvdh780iRi8i4XH/xnSFRuk5iDNy2lYJRsvMio57fYOcro+XWuIbmCjBGbXvwAhbXOn6B2ZxZ+q5eZiAtxqvp+ZXI54l1ZL/mL7oBRKxfzfW/7MBvjONaBDUuZ6Q9YRoU/LWZIWwVrMo+XvZfBcgkVUiugTrTIedKdMTOmYMnuJNV/rMCxI+s7Z3mbCo+8h+Bg86R5E7x6/NN1n7C0I4yZjKP7Mx1FCft44sQ3tXtvnpUBZpTNZJkYlwK/sCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPA1Ct6hmAmJnTAy11hc1aBS77a4XFoz+vneplZWWQo=;
 b=dnNswn6JGh7kLwIdKMarKuQOj1i8bDW7Pd58ySIz6yiCaMgcWqxsaAGGPDVIxTiw9RAP9GgjFXXq1rJGdfE5G0B44iUTIfJiTbD6sQvtE/pwZOgtoSx6wCJJejTKCgEhXGVBX8ojNgcCmvhtMpeMQHyqgqAEP/YNp09D+ISYkpA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TY3PR01MB10906.jpnprd01.prod.outlook.com
 (2603:1096:400:3af::14) by OS7PR01MB11424.jpnprd01.prod.outlook.com
 (2603:1096:604:246::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.25; Thu, 8 May
 2025 23:36:15 +0000
Received: from TY3PR01MB10906.jpnprd01.prod.outlook.com
 ([fe80::592:9b7b:ef57:2dd8]) by TY3PR01MB10906.jpnprd01.prod.outlook.com
 ([fe80::592:9b7b:ef57:2dd8%2]) with mapi id 15.20.8722.018; Thu, 8 May 2025
 23:36:15 +0000
Message-ID: <87seleptea.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: =?ISO-8859-1?Q?=22Uwe_Kleine-K=F6nig=22?= <ukleinek@kernel.org>
Cc: linux-pwm@vger.kernel.org
Subject: Re: [PATCH] pwm: tidyup PWM menu for Renesas
In-Reply-To: <odkmm5vr5sav2e2bithwpwjlscw3annav5ccbtbnllyyfjialj@yfhbuac54xcb>
References: <874ixv3nqz.wl-kuninori.morimoto.gx@renesas.com>
	<odkmm5vr5sav2e2bithwpwjlscw3annav5ccbtbnllyyfjialj@yfhbuac54xcb>
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Thu, 8 May 2025 23:36:15 +0000
X-ClientProxiedBy: TYCP286CA0256.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455::14) To TY3PR01MB10906.jpnprd01.prod.outlook.com
 (2603:1096:400:3af::14)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3PR01MB10906:EE_|OS7PR01MB11424:EE_
X-MS-Office365-Filtering-Correlation-Id: d9b42d77-4082-4646-72e8-08dd8e891fd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dNqpg+uR7RKSwAVL+asY/5aLfLmajaBkOXKHWYlpT3BXftf7lfpShWSWqcLd?=
 =?us-ascii?Q?xF7CGxYCwFLOqbcFNCSFhV3H+BGw3iQcYHDm6ZnitGQUDXJGKj10iTlqIEor?=
 =?us-ascii?Q?wHD+3zFySY6/i3QFvadWGkpPB53r0josIOgq+cpJJlHtkaiLtCcFx2XWWn8j?=
 =?us-ascii?Q?yqkMDlSYSNqHDjjB/Q1iEawSGsgQiRp2sBxafV8SQsKzJkxOoGJivSDjHe9J?=
 =?us-ascii?Q?LczoeZRv68pc9IkcFg0YoQOinc2PkYuXXkBniJ+w51KHKnbbdBURr7xt3qW0?=
 =?us-ascii?Q?4KYOvUCcMItOZWfy3WGNncRNxjhmljxe/U8uT1eWRRY3JmCdE3s0BgRGRc47?=
 =?us-ascii?Q?f9vYo4w4XBFsbuThiccaKdWT3z+VVIKNYOyztxyJeBLqLCsW5PSWKn0SytSR?=
 =?us-ascii?Q?855dHviyo8RxZRjg96r0WWbP5HCckoJ1QaJYyoyJ6dhY9xvlfUqx/uvN1aCU?=
 =?us-ascii?Q?jzObdIUplhalbV4pywT+A85pNFpgF03ReTVUAspjZWKa1OdzMtfO79z1wWYr?=
 =?us-ascii?Q?XQI3KEUEWXyGZlgqEoPEdK7p3r3PoepjkwiWSmAe0mu43wbC1sp4sbv4zTm7?=
 =?us-ascii?Q?QEvGsUd54CG5zINTwSQT7Z7HDtSaFBnFgVrTSIREGLJnHitWq1lFTOZiN0yl?=
 =?us-ascii?Q?GItmgmndCObFHgWBCH80I5k4mfnjY3tVzjISXCIMcAadmKYkMXOnh167lCrd?=
 =?us-ascii?Q?e2ROooPosjDEYYphhYI+Krgu9YKz+znHlHjo+IN7oUWmpd0KK+W469gecvxD?=
 =?us-ascii?Q?uRUF+M18ixp+zZvz89Q3FxjvmzIGAJJBbQiE1044Z0Gx6sngrUVwzvxdy3Ux?=
 =?us-ascii?Q?LNOqh+2exfyvKA5NRq2IvHwhVAkoZE1CaXCeqz9fjsdmt4sPGbRZIb8ZAdFv?=
 =?us-ascii?Q?vlQfVa0HgBvpgU4N1eNmEvoDGsSEDIXQSQ5zhIUmvgtHS/4baPryHnPZcv51?=
 =?us-ascii?Q?GU+gIV4AXE/JxYbGDzAJzsLSS1LcgguytHV+Eo4vXUxO8mf/6udU+J6Ly455?=
 =?us-ascii?Q?50YP9SSQN2igPyUQAN1gPZntM5aWFHvboeiE7RQ2EcRS9AudABg97VH3i65O?=
 =?us-ascii?Q?TQmM1dbfXUGRozSzHVJxflsw20VeBGw/PPGmqdvw+q+8X9Chch+ory65RbzX?=
 =?us-ascii?Q?W8yb877FvzwUiU04Q4bBffeI/q6+FeVGYT/sx6dkQGWVNAukkHJK0mKq0LU9?=
 =?us-ascii?Q?fL4/y8WBoGBAsTx79jO+i+qq2Moiwm9bZcEcJfAJwCinRr55kWt9vn97QDRo?=
 =?us-ascii?Q?O6qJkL82+HlXYIyOFZ/e2qLzuGKMUj0UrFpMW/+UWoJRTRw/HkIOYYXdRK8l?=
 =?us-ascii?Q?J0L5enmmNfW3oo7dBkbrFC3kWIqg6InZDEOWyzEJuhdqL3O0DdfKiHQO0jUk?=
 =?us-ascii?Q?cSW0Wf7deMquSMMkd2wd4Xn/3KExT2+m46FWkMN7M9p5nzGTInG81yUkxeal?=
 =?us-ascii?Q?Drpx+dcwOd0+kHp2gmDWfNIkboW5hHLdQP6MLaQ77K5P2TvMgp9XvA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB10906.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZBzAUpCe9F+sCpFxNAjF5r7HgC9Vy0qVVTyZBC1TkpxY+cm25y9yIng+6ktO?=
 =?us-ascii?Q?tzjf/C6ef198TBLocG72jM3Bsu+bYuxZOGd9qdxW7hRP0Cv/QXzyrUPKWNaV?=
 =?us-ascii?Q?qYQtEC4TmjNlBIMXoMMdKcCHA4nkDxurFI1y68ZHC3lST8uWAC0WP3cB55wB?=
 =?us-ascii?Q?Igs7bw8cRRRRBRISysQvpyLnNoh6fI8uBIBkxQUyV3TgEfuoZzpSGxzuzKGW?=
 =?us-ascii?Q?w3IMiXxKOOFwFIC3gvwrDVrYdQ8ga7+RIaMX20ZKBkOlaL8wP0dTuA8kCEWb?=
 =?us-ascii?Q?fYGu7/gmHbRf0J1v3ltcPqqHQM/AtGzaXKDt3ctxrYnLtFZV6wXew/eUUf9Y?=
 =?us-ascii?Q?R8Ega1oWYglhBND612eifRCFz48DeokYZmsLKdMG/7q7jR5EMxzuanhiIIxj?=
 =?us-ascii?Q?tT+C5+1B3RDl1jLIDt2Ckkj5xqm/nWFtEtzU6iu8hnSd0vOy/4GHr4+mIEYP?=
 =?us-ascii?Q?WQW1x1MvvnoeMKv6MuMJQYwvTARi/Sa0tx3ZNKi7lqiWRgg9hwR9TqIREuTy?=
 =?us-ascii?Q?tiDpcN2FVeOwtf9G1pybKwmcJDMzzikGvxDpzyfGW38CHxR7716bcag0Osip?=
 =?us-ascii?Q?hcFheIU0TX3+WZqopGkkGWpN1enV0WoimEW7NGiySzk0APhSsMEAG1mRNGxA?=
 =?us-ascii?Q?UM9e2aNdVFNRGCuhlo7ZV2Oc0ZTDcE3nToHaT/PJgUSbZVJ2SazZ2+VD+p7F?=
 =?us-ascii?Q?Vt2Ol/0ZJVuq8pSgoJSkiI7xCIviDMd4CDtHYvI9Z1E6aRweuGzILe/gq/MM?=
 =?us-ascii?Q?3ssGX7SaMlp1Y6mN2h3NpEXkI4TQOEmIyq3bvAWcGQKrQCx4cKd7AFponzwK?=
 =?us-ascii?Q?ATWpAEdCZY1SPlSUA0g2UGoEMiSRPeIi8neh4E1MecJzM+omhp8qwW8LBi+n?=
 =?us-ascii?Q?Vu1o61M0hSF+ppFC7Gyh0p7Izh1l7FOXgDk6L46Ty2GgyqZPhmImWAzPWGz1?=
 =?us-ascii?Q?0fJ4tG2k3VGvTgEpeFC67MgoiEe1Z7ls/E/XXRogTtPTffNestr2i7W1z8wb?=
 =?us-ascii?Q?gJvsUOp25kl5B3tj2nSSwXBv/NUi2HBjRgkaLzlwe5rBZCA12WdkllU8MkKe?=
 =?us-ascii?Q?p1cBOPoFFEpKaQt5BPtx0X2OnA6LohDt2e0HaHE88Ej8EUjc25VpaPuh121U?=
 =?us-ascii?Q?dlr4FVo6vf1pqytYEMZu8wLfUPYG0FXOS1NgutYm/av1n2jWXj9dn12mZMVY?=
 =?us-ascii?Q?iFigbtNflq8wYF2AKYSoMknH1wYB2FOdUCx/raWBVWe42r2gZ5qO+Pnrr/iv?=
 =?us-ascii?Q?b8x4+XwzYdoIYf1ob8uU1WH0Kl7WrxTM6BiHtn1JoeUHbtYCztiGneMSvY0u?=
 =?us-ascii?Q?BRo3gHZM9R0DUsqqGoOA9wcbZXx2HTRUIWBtcsve78xE4PBakWH91LboDI77?=
 =?us-ascii?Q?xV2njptw3m1ntZRuxdAV6Wt4vILLXi7KfqtjK4xOI5QkqmHBmanWeYbocq2b?=
 =?us-ascii?Q?CQa5/QZALhYsOuctEN9nExl1QuQCYlHW+5otndKamYuxYVhrB6spQGaU7j6M?=
 =?us-ascii?Q?bfPA+fc7QbC0XtGDUc7MST+zlEa3mfNyeIlwNFm9Pdh9qLSLglVCgvqura2Z?=
 =?us-ascii?Q?9SX9j2GtKR8YdWoCJVGrLY6STsBxO0WCcFXF09wPs2XOIZ1iHtXpt6jYqXrw?=
 =?us-ascii?Q?SA=3D=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9b42d77-4082-4646-72e8-08dd8e891fd7
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB10906.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 23:36:15.3607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: svtvCr76+GwI54P19W/yjj3R+4rX9/cW1NgQPMGm60ZNWp2wBtCkKs2A0cu+nWJMjN6+Tx5JMwSOCPT0OIfbx+HwJNGtAMJIY4WVJF2CeAOiG+fzeHqdqvEida5+r3/P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11424


Hi Uwe

> > =>	[ ]   Renesas R-Car PWM support
> > =>	[ ]   Renesas TPU PWM support
> > 	[ ]   Rockchip PWM support
> > =>	[ ]   Renesas RZ/G2L MTU3a PWM Timer support
(snip)
> Hmm, that file is supposed to be ordered by the Kconfig symbol name.
(snip)
> Maybe rename PWM_RZ_MTU3 and PWM_RZG2L_GPT to start with PWM_RENESAS and
> then have the sort order of symbol names match the sort order of
> prompts?

Ah, OK, it has symbol sort rules !
Will post v2 patch

Thank you for your help !!

Best regards
---
Kuninori Morimoto

