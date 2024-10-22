Return-Path: <linux-pwm+bounces-3748-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E12BC9AB34D
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Oct 2024 18:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C135B1C22856
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Oct 2024 16:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1701B5823;
	Tue, 22 Oct 2024 16:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YShDMB9U"
X-Original-To: linux-pwm@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010022.outbound.protection.outlook.com [52.101.69.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F1E1B5337;
	Tue, 22 Oct 2024 16:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729612915; cv=fail; b=C8TeBQaRrK2/dVf+AT9XKWOSC+SNvykw8WOxXeuC07/HRcUHee/0PcA+sNzIj6uVXyhQr1co3fZMP48kWOgQ95diyX/tMvuvkz5LQ2dbMEo859cAE80VQCyETwVmdBj2rP4TJ+hMfb9KHQYseYb0LqsnDbUEpW/JOy974gkS100=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729612915; c=relaxed/simple;
	bh=iDG++B391EjlZhhb17gw2/NsXyyKFAaZmgJmRWdAPhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GnuBYg603LZlefMB3WG+ffRqqX6Vk7fIGSFTz0gMgj9uVvy8alE+JzLttC4NrtbsjJP98Y2QLmQPBh0vz/SBveXOMK3+Hu6y7rttuewlKyE1KwbWexn8hNcZdh2pyDim1JOlUnQjDzbW6T+s49ZAa1BJcrVyZzuoiHjpF7to4VM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YShDMB9U reason="signature verification failed"; arc=fail smtp.client-ip=52.101.69.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cFIWCqFxaulvam9YJDzJavdZTzSPifgEFtwrtD4xFbwQX7inSBHYk8urmCVkRbhnF7ASSuPqhs84yuBPPwiUCPzlWRyv6EkBHxwaPA9SS5wO0x8vqonlfaB4LEhSfsSJu2w8BKNriL3IsVk70uhPIKMbeECoC2qktk0KUhj4r3VphzTs5I4rD1Vzr69VUHIl6GVgWPyvg1aYuND2TSXZWC6i+ARxWhRqvhCp/+dfzIJ0v2YpRr2l3gj6VaSho7IcL93pmkPmt8phmof+yfOFwpQ+SYPwt3YFlXEqJGO1CpzJfyxS5gkt/z1SEGMM+43D6Jq10dcpKAmb9LhXQqpwxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m42Vk7PiEQj0Cn1GBcu9AsU6c9rpcvqhftjTPQC8gic=;
 b=AmBM9RSJqo8kwSxPOZAWEO2JuNdGpHqUZT69gVh71kMMa19HWgtneK6T6wHjlZUy6By5tlc8k64IwhBVCiC1JBTJpbxYB6GNninZo+QHn1S8DSSJWrFFdw0EsPmrwYX39r1xYF2aQM00XZ33nsQdT8Y6qZTxXvlcb7boj/3yJs7/8q+ufPitvJ4EXKaVIBhZax+szzwmF3nLCCyufLNLuvRIrcN5jV4yfbDX8TJFRZ7Ymb66iu6ETD1SyZCyaGtu055LGgY96ePesmDcFxD/kDC0Bcd4z78t6QWh3Qls3U2LYDDLtavy/e4O3f7rPgPWK3GnB3YErzYJa6jGrTwcoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m42Vk7PiEQj0Cn1GBcu9AsU6c9rpcvqhftjTPQC8gic=;
 b=YShDMB9U1zpMYhhlx3ApsqUSls6SOq8EKwYu/zUyQznDTYWh6r7NjoCLOtQVum6T12J/VZUxpjtEBpVz1WxANSytr+ZOoC+8gEexKfUY3FOKBYTIqmPIRXYrLnX8Dno+lszXdPBJ1EceOj5GF8S+9+N5vVvCKWQAATfO+SuDw+MYIckIhwm1DQqg3b+dryXyEss3mkmoX/TgfwmF8dMkf+lTKdhe2dK2kLmORwigqvuIfPSjWtVlyCO4eobpcxqz0ixtvK/BEyQmWeucXAdr4csCc0trQ2rqxwYw3VogvjepnVokzYBshkkDC1S1A7llt6NsmmuuDVXh0j7UqaDJvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PR3PR04MB7417.eurprd04.prod.outlook.com (2603:10a6:102:8e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 16:01:49 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.024; Tue, 22 Oct 2024
 16:01:49 +0000
Date: Tue, 22 Oct 2024 12:01:42 -0400
From: Frank Li <Frank.li@nxp.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Marek Vasut <marex@denx.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	pratikmanvar09@gmail.com, francesco@dolcini.it
Subject: Re: [PATCH v3 2/3] pwm: imx27: Use clk_bulk_*() API to simplify
 clock handling
Message-ID: <ZxfMZobFdBA7ffhU@lizhi-Precision-Tower-5810>
References: <20240910-pwm-v3-0-fbb047896618@nxp.com>
 <20240910-pwm-v3-2-fbb047896618@nxp.com>
 <7kplk52i7e2nha5ym4loza5oc3lwghifjfk3aut24w3hjagfk3@zusb2naeaevw>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7kplk52i7e2nha5ym4loza5oc3lwghifjfk3aut24w3hjagfk3@zusb2naeaevw>
X-ClientProxiedBy: SN6PR05CA0019.namprd05.prod.outlook.com
 (2603:10b6:805:de::32) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PR3PR04MB7417:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ad8fa24-fdae-4057-44e6-08dcf2b2d626
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?DnsGjtgjAjnZVn9D5Q2hRgM+ATZKNuih/FB7oqPdd22Z4/T11lBTcc4z7b?=
 =?iso-8859-1?Q?Of9Ix7UUolB4+LVwHhiin/ss8Bo7Iou7HOYd+D4/O7z3OJISXajUgPsbGB?=
 =?iso-8859-1?Q?bEKZnVnJZSuMBa9uo0wwGed40Kp2jQth9cmjorIFV8Wsko/3/hASMU3CoQ?=
 =?iso-8859-1?Q?ogjBKVfabIyVx08M1XFnbIjzs1U5x/kI2GsfKHGJAtmtJItnjth7pHbvHr?=
 =?iso-8859-1?Q?CB8A9k4wFZ493uAfG3N+OxkyBl0p11CG4Fvt4AQrIIgdtiPLRM1h3RkJS6?=
 =?iso-8859-1?Q?lxZ614KZQAGfJUXKodBnHfHQt9rfGVg9i15l1Pa2sHqG20aVb2GiDiVsnT?=
 =?iso-8859-1?Q?HwRkSV3D9rDlP/8i3ieGg8ouLzLe0ThV9QQhdZW3BYXYmFJYYIGsgTsefc?=
 =?iso-8859-1?Q?n/4Oz5y1Ly5xXJbDjc792gwaAEennViiFIHBJ2vpnT8C/aFvnJjL/9DiVK?=
 =?iso-8859-1?Q?y6jWcCriZECjFhJOH80Q8KLFlsSOdnMnNANzpPfzm+JnTOYLiOlu6+twjt?=
 =?iso-8859-1?Q?40PoVuFSc3/YJO5e7tuE56vSNtkhJ/qzCok2r+ZEUFNm2A7W1J3SlV07W0?=
 =?iso-8859-1?Q?scT7OcCC1gffZqWxgnkHwQwk9TuSV57QTPe90KeUL5GZaETpPHzC1eDWa1?=
 =?iso-8859-1?Q?/94Ze8qy6HFGirNyBoghDyXU3FLOOj/7DzMqo4dJXcwWdVOH+r6QIUEwGl?=
 =?iso-8859-1?Q?U8eSSh6SS4LgndqofNIUhfTbE4U21UQOu2WvqsH0M+hkf8Bh/wARsrQqeq?=
 =?iso-8859-1?Q?oOxBtuKKt+vWJ6i+fqo2VywM34MG0OkIOuJSS1Tboc8zk+iDhl/YUaha7W?=
 =?iso-8859-1?Q?1OdfRYzMvOBKt4wpk4t3GShV3/3YWCXnhe9RHZt0KxdlxySveGu7GFskq3?=
 =?iso-8859-1?Q?OzfFWEaK3nUfBgzl+hH+sm5gLMhuSb6+w4xgDOS3y4+uBvAMxnKiLBGe0m?=
 =?iso-8859-1?Q?CYsGPcYT7W+PO2/X6qviM/vHHNgnPFVwtcyl+AaPlyic2H8lZy+cvbHpfx?=
 =?iso-8859-1?Q?PN13Fq4KiaPAOwLQKmMoifkwIVjcWqtJXCcWzHQB3HbOeW0nQNtm1uFmfN?=
 =?iso-8859-1?Q?VH0opqZTbu4bQRx+CoQJyhRn2fxXa/T54DTBvkrzTx20RfzyljyVWFgWbn?=
 =?iso-8859-1?Q?8khDGbAmUuWpVTj3+vo7NDjKjIneeJKZMUsdx8SXYUJmHqEL+en9rbpsjb?=
 =?iso-8859-1?Q?//n5+WM27M3e+8UXgh9eeQTZjWdSske8yEppG0UfJ67IYjhVBpISU1AifW?=
 =?iso-8859-1?Q?yS/XaxgGPmVhWab4gsDxgN+97FhyzpssijjuKeSY9sbMHMibjScQ2ZAXjk?=
 =?iso-8859-1?Q?C3hxMgPqmB8LGUbcQusruFfK7HpyKCniqKXwNOFeVNz71rqWkSO5nlJh2A?=
 =?iso-8859-1?Q?BVdRIhQ+h6Yh17z5FwuFbmFCzn8n669s5V2gjpFWQAiyyDqioVaUoL62Z7?=
 =?iso-8859-1?Q?jjE5xHtuvf99VNeU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?o36YfO1nLR+Q2+Wqgvz+bRQQ5Um+jMU66rYaWLQ80sRZrMAovEyR5231ce?=
 =?iso-8859-1?Q?4Kq7mEbSOX61R0zriJUH/KBMGDSLrDELdHcPcd+FBfD5vLTIWJu2tDLo+F?=
 =?iso-8859-1?Q?sc4lG6rm/pMThbDsO4FQE3SXV669DGI3GNYG6oQB1so7F2bChAqagF/5kj?=
 =?iso-8859-1?Q?OO01AoRD5yslkJ4l+uk54RO/hSMFeH7orIdo+gt+U2spKRqcyNSkiZbHcb?=
 =?iso-8859-1?Q?FDQoKhk93xvCR8SgloMBdR3a+HPecWE1VRmNbG/t7LGi6jinOjUm/ZL8Z2?=
 =?iso-8859-1?Q?OIDoHfLOQWeRW3C06ekn3Q0qKDBEMllH/z/izd9p8C4PzXevydSpHus3cq?=
 =?iso-8859-1?Q?8v/j6ckFMZSDRN4TEpL1oh1PwvUJRPN7BOs3E9tyDjDJSVBzy092tPcGWx?=
 =?iso-8859-1?Q?d1IA+nHGzcOSVD4J9qhGyK70sBtluGlN0+/8j5shO5+dDvDQb44raTM6L6?=
 =?iso-8859-1?Q?OZbhdqLKdFoXOgZrJBSrtpDSFXAEwNL7n7TOlyOT8DKyjxaNM9v7wga+w2?=
 =?iso-8859-1?Q?uZcm3En0dGJd1M57osoZOeROhwR/fElomlw4DRXsjvnU3qmdByzC44XbnM?=
 =?iso-8859-1?Q?qXv8fpGEhy315SYrX/sEbCvOv+6Kbq0g/DN0wgoeL0+9aMk81XuM6tLcxg?=
 =?iso-8859-1?Q?Ti4rsB7cmw6eCUda6seZn+zkffianQVntY9LeT0bz0mAAwPSlFVQRIonVD?=
 =?iso-8859-1?Q?zG5nH9ltMCm3ayca03ztr1wWl7eyumPC5HddQc3dvWwb2LKir8Fk7VWv3G?=
 =?iso-8859-1?Q?a/2salyPVGVnOW1nSxhT3rvQTt90aUIGJP/mN3WMo2dXDP39vSjnsbh7cS?=
 =?iso-8859-1?Q?zopR6sYXloEMhlnTZFHFBWgs7WBuj4SO8BS14YlEQ+g0iKDNj1M7pcRUWz?=
 =?iso-8859-1?Q?7ltxgDG2V5/ETNk1vv3AjMsSFaAdTvssl5vtzD0GdEBaNvncg2PNG4IBy1?=
 =?iso-8859-1?Q?U0UYkGbr1l6isfwZKHOO+3vuHG8/myXhhF5aJWF9khMwRX5sQNq8Ksuph0?=
 =?iso-8859-1?Q?4jtrvUO5iIYy6/qDZpDXo6jArT1dqrafip3U7ikb3cc+OHpDLM3pjVJtCx?=
 =?iso-8859-1?Q?eXkMAcRF59VrGnwKtHOJZgAp3O61uHxPaVmwK7Bn0keaEJk/1cgHDtzafG?=
 =?iso-8859-1?Q?Q1kg3LWqxTXU0WdhqB50/sJcrLBBW6Du1uwW6Ow1BM+rVvO5oH4fw+vpfN?=
 =?iso-8859-1?Q?ksHS1I6FVRWltJPDDb3eO95B2ZCkdkzgOSc1st39/p/Sxv+Ng57nPDDAbs?=
 =?iso-8859-1?Q?n+F04i1A8YNOcSd1Hvd+BWNQD79tFP6dmjsaUwSZmbIFD7Y1Pf+hEfcIkW?=
 =?iso-8859-1?Q?iSR+FFi/OqhufpbNyJmm69Y6SdiHwvWACyOvzEOmojc/2theygiDxq9dxl?=
 =?iso-8859-1?Q?bjQ5CfBJACH6O2wvUw+WLw2C0URg/jSvW0zs0e54ha1k6okcsADD/+c4gg?=
 =?iso-8859-1?Q?M0hBg1jBOKmxYmkVE0xO9t9xh9Ig2yrv3RVR0vf/KeviSiK7Z0vfW418tl?=
 =?iso-8859-1?Q?vFTsiEPrIZTwBhJ5wBTQYe0E7wFGqG+UCU5zM75iFRcoja16YQzvGfBxji?=
 =?iso-8859-1?Q?FpaM/M9dl+kKk/LRAb8el/b97CiHYoBaMaZlAu3NVQOPDqQN666wH+zG4h?=
 =?iso-8859-1?Q?g2Gq9Ovx4ljD69vD6mwi8oRvv5ee87Ezpn?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ad8fa24-fdae-4057-44e6-08dcf2b2d626
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 16:01:49.1895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nWrugPw4BFNXPTSFtRT3Pws5NW1fZnojgpGMjdjINDL4Mr1wPtYE57+cTyMaHpxrlO4sWHwDZWwV24EW3eVDEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7417

On Tue, Oct 22, 2024 at 08:53:40AM +0200, Uwe Kleine-König wrote:
> Hello,
>
> On Tue, Sep 10, 2024 at 03:07:19PM -0400, Frank Li wrote:
> > @@ -229,7 +209,7 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> >  	int ret;
> >  	u32 cr;
> >
> > -	clkrate = clk_get_rate(imx->clk_per);
> > +	clkrate = clk_get_rate(imx->clks[PWM_IMX27_PER].clk);
> >  	c = clkrate * state->period;
>
> Unrelated to this patch: clk_get_rate() should only be called on enabled
> clocks. Given that further down in that function (see next hunk)
> pwm_imx27_clk_prepare_enable() (or clk_bulk_prepare_enable()
> respectively) is called, that clk might be off?!
>
> >  	do_div(c, NSEC_PER_SEC);
> > @@ -259,7 +239,7 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> >  	if (pwm->state.enabled) {
> >  		pwm_imx27_wait_fifo_slot(chip, pwm);
> >  	} else {
> > -		ret = pwm_imx27_clk_prepare_enable(imx);
> > +		ret = clk_bulk_prepare_enable(imx->clks_cnt, imx->clks);
> >  		if (ret)
> >  			return ret;
> >
>
> I applied just this patch to
> https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-next
> . The others are still under discussion, right?

Yes, thanks. I think 32k is not necessary and need more research.

>
> I see you signed your patch (which is fine!), but I couldn't find your
> key, neither on hkps://keys.openpgp.org/ nor on

Thanks. Fixed.

> hkps://keyserver.ubuntu.com nor in the kernel keyring. At least the
> first two should be easy to fix.
>
> Best regards
> Uwe



