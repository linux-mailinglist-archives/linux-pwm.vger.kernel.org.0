Return-Path: <linux-pwm+bounces-3775-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 758FB9ACEE9
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Oct 2024 17:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 317F82861DF
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Oct 2024 15:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2321E1C8785;
	Wed, 23 Oct 2024 15:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="m70i6GN+"
X-Original-To: linux-pwm@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2069.outbound.protection.outlook.com [40.107.103.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446391C82F1;
	Wed, 23 Oct 2024 15:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729697743; cv=fail; b=tw0ELsuRRUL1G+94H8tN+adebw0lYd+OObYz0M6bbHCdYKVf02ivVpbZSoWNzfyo1qk/ARCNCZJSQYiNs4IlscHE0uHJnwCgPF9hYn/r6/QKyZkEyShXDGODST0pGj1EtKdiej8iPUFsQWJfXps3tD7e6PDiMqr2rSa1qDrPTMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729697743; c=relaxed/simple;
	bh=76ZT90y3N2pnpsbOcOQU6dczwzp6AUJv1baAAekcP1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YjJ/RPYBmMoHD4ASgfHkfXTg62o3yOPT3zR08tTFa3Tv/b4gCIcrqel7xEcx20BKROtF7lnzC29MY/i9VLEU3MLhhM+vm1hRvm8EiquufI6auxJsD24pqjphL9sMJT8i8f42nR8FWKpjS7Ipi5Lnv1qDmvqV7O0IaC51O3iQ+Gw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=m70i6GN+; arc=fail smtp.client-ip=40.107.103.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WinBda6CenmlGhATnY6kgOHp4gLhiZDSfo74N2rtjVLGNKauSWOClUuA5FFeBOZhPNPWp8CwBCGwhPgPtHGNbtJnm/B42HAhAMNRgfQV4MG2v7DVfi4eSS2J6vMC3xDcHbF/oZk0jpiWhnAGENRxbL0YAUR1S9ASQscLQ3+8m+x/0Qc6P8U7/8hnbSPJzfwnhftdnMEamfrSIWoaLbIVM5AXb0cSE8B1kK5//Q1QJSg9hph3wlYENdPIEo+43fjt9kToLFHIGqSpIu2Oqw7GlIfaEemkYSY8tWbGnToBkEkmqNlqR5Myb61AaAtQ+GLjLAxOpsNzZ4KpB2Ah4xmtpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pujvPXs5pgN2aquzcwxi3OV+hrb00tG5EO/G+ju0/d8=;
 b=NGjhlO2jdDJdTob9t7chz78DeXQaU0Eo6OM5ckmXa7mf4KP3L2yB01mn4th4jk1R5GXfNbTK+zK+trZJw6Nu54xVcrh48tnG0Aexzhoh1iHPKUPOsWA424Oi11wKZcdWaJIbZ0cMq/BOYYEgw72IqXQHC8B+HlsZFZ3gL3ya7bpf6erdFJgY7Pzry/hPPeljuBRMI6p4oN8azFY39Nc7+R/RXFS/2e3ATyJPOYU8Hf09x0PEEFkVE5OvifCEmqt7+9PIiFkftVPnq6ZU6i1LtzzF+j4dCjqj0G2ztrfpdyS9spQXf+O0HBBmHXrWmNy+VCtszGWn9YOeIC8nc7sE0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pujvPXs5pgN2aquzcwxi3OV+hrb00tG5EO/G+ju0/d8=;
 b=m70i6GN+YlKsT4LLwguqBqL/WeiFgHMh3vcq/7zlVmoCvwItwXxoaCmMzeR+2iJdcGfWqT2LuNGPW8k7aQUOsdp+I/K6Aw1ENeZcKJeHRvAVGFykLZImoFWzMqVlE4/+dmY7NrpH+nVQ+VRiA0DIbHO74KqW89pOjGbDAcDA+iph++IEkagGallbbTYcFhiUR1oXJEp5h4I4ur/V51b10ML5U1n9zXj9NN+dXeAevse6Gspf8Ha+HtmQiMFCXpNOso7SWUjdkpDgODu5+OIejrCdJKW8s6sVaJ6l/Z1QvYisX50JiQg9NLrSesSnKbXxUw6lxJkgbQrGZ4uYJWsaAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA1PR04MB10651.eurprd04.prod.outlook.com (2603:10a6:102:483::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Wed, 23 Oct
 2024 15:35:37 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.024; Wed, 23 Oct 2024
 15:35:37 +0000
Date: Wed, 23 Oct 2024 11:35:29 -0400
From: Frank Li <Frank.li@nxp.com>
To: Erik Schumacher <erik.schumacher@iris-sensing.com>
Cc: "ukleinek@kernel.org" <ukleinek@kernel.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: Re: [PATCH] pwm: imx-tpm: Use correct MODULO value for EPWM mode
Message-ID: <ZxkXwTXwfkC9W5C3@lizhi-Precision-Tower-5810>
References: <349a25ddce02d55cf5a321f27133cae1f34f1962.camel@iris-sensing.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <349a25ddce02d55cf5a321f27133cae1f34f1962.camel@iris-sensing.com>
X-ClientProxiedBy: BYAPR01CA0004.prod.exchangelabs.com (2603:10b6:a02:80::17)
 To PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA1PR04MB10651:EE_
X-MS-Office365-Filtering-Correlation-Id: 5313d03f-f111-4cdb-671e-08dcf37857d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|7416014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1kj9ueDeiNh1NPtcPLwNC5dIg1wFY5P9uPaWuQGQLA/UDhgPuEbkCcbh+CON?=
 =?us-ascii?Q?OPd//YL6QVFvDybOE9oO1BA7FNhd9Y5FMpmkkrvyqe9hWu31YIn6d2KwNPTr?=
 =?us-ascii?Q?bTqvkMN6PlrWXu9UHugSZ/PlNrTm/oKTKkcZDa1QGQB+JOM9bekKlVBO/fBg?=
 =?us-ascii?Q?AJrHPwhd/5Knv0sj5UusoEoShKIfZVLRkRLTpgTersbynA0ot4rHv5xZM/3U?=
 =?us-ascii?Q?3dwJVMwV28cw6O9FRrsjLzBNCc9dbq2DzfYc1zmnx904omBl1Zh8BpiUOHET?=
 =?us-ascii?Q?dqsz8lzsd7T1B2mNWZlMMUwwuQvyWIHGIoSwwSOfDfxnLScfCYhzdVsfQvPO?=
 =?us-ascii?Q?jZT3kIKZUy40446FXRo+idRktNpKCBFT7+wGriEDd7+nP6/y5hbxPfuBY22l?=
 =?us-ascii?Q?noskT2hZ1frhsVQIc1CB22inwxnm//OV0dtnwyOeuXwcGxNi7eNgpkW2CONT?=
 =?us-ascii?Q?iX4XJK6vdnY72FknjWvDyrXyz8oTXu9D//aBPxqeWklfCx1wfv4Uj7b2eM+V?=
 =?us-ascii?Q?rtX/oFDi3PUpkCMb1ovsb9zoC7ygavjMkA9PrMTPZqjHaZ8mvfqkHVJ5jidW?=
 =?us-ascii?Q?DYygtpOYppD9SrZUb2VDeehd6mHEqo3j/SmITga0JXQF+gbdiXs3AGvjBBh/?=
 =?us-ascii?Q?IywLzs8mUjosXdtqNgWZniWkee4I+FGcebJLuqZ0XfJGIf2bqr7UT4QAQv03?=
 =?us-ascii?Q?FFYpsv9bK88pdRQ+Fmoj90JxSNV2DhQscUNgSRDInjXTcyUNQ2zB0XZW4OKE?=
 =?us-ascii?Q?Mcr0PeH2ixu6otXos05qQkrECKcNjoN/Jz855IAcB6v654BkmCNAxgLJYzlt?=
 =?us-ascii?Q?CpJh+um6RYcwloymI4T34RWoZMv5MjL0+vpQ6sWtnG31roNNcNbWLftVYWER?=
 =?us-ascii?Q?0f//Bc2Iv5ItwYv6+2/UIQ3RdTTUdJIYNPMdUOi2t/NX0hvgDoljjxNVcZ61?=
 =?us-ascii?Q?M4GQ1EKUg4EzLHDsriu91FRyg47x8NQFJTJ2dBcUv3bTW3OedRqKGMId9ecP?=
 =?us-ascii?Q?02XsvS0LFK9G2xcbuCcvVpy3FHTMRjhF68HJYVHIr53sP4gSdFbctB76UUXu?=
 =?us-ascii?Q?wJrhBqkVWG96uK5Ht9Fdyzf66S9ec1NFvr34voAebJOgHB4Zq+pHaR/M2yDU?=
 =?us-ascii?Q?vM2wCdLqqAtJv+gX42sVgER6DouAuf14r9TnNI/zWJ2ntMlYpSskb5TvCc6c?=
 =?us-ascii?Q?JIQxiHwFvNy9uI9lqVcCoHAAvvOFU265QAb+U8C6OU6QWGqrY/fXDClvrWw9?=
 =?us-ascii?Q?KQ+Kj2rS0ySmxySLlFSreKOSFncD00pCfWFvqDUFLFD20XkEHfJpj5qTjGO2?=
 =?us-ascii?Q?t+WNP7gB2Yqb56La8FhlYQVF/Ya7WjuQu+vXejkbQtMlt6vK4EKT7/y9go/1?=
 =?us-ascii?Q?n3HOCJM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(7416014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J88/I2PVuUsGGU2TKWHaVaBIymucakITxk7LgGTdCR4nD2k9uXrxXhDNuWaW?=
 =?us-ascii?Q?5Zb10fKd/MQuOhBXS1mmd2Wev5tyIeYFItsSOw6g3Zlj8nz1JVpiuIhdtqNp?=
 =?us-ascii?Q?+ahoxXJuPcw6jLSqZQyS3I7kd0cq81sOFD4Mcm+bqgegnOynCpCeY5lemIdl?=
 =?us-ascii?Q?B/CbUxvOV+bm3DG1WaeCV8irSVGbIiFiYflood9PXtBF46GB9izWb948MQju?=
 =?us-ascii?Q?p69dS3qyHXgTCmA4OnpDanp0eCwogC9weoseHGjTohikD+taeXEQnwGFLfSI?=
 =?us-ascii?Q?CFW5M3Vy8qH8WMwssnoX5Ny6WSa78GgIMke0++1iRFu3TVw6rocbSMUvZLhG?=
 =?us-ascii?Q?U6mwO6saxKG3DW5RrjaYYozBPtpj+7Hd26omd/0qB1unUXH1eky4Zn8rKjcE?=
 =?us-ascii?Q?ijCigeYvS7LnodAcImgPntFRxh5hefC5sRDerFlE1EimidiC+xkrFtA3gwGo?=
 =?us-ascii?Q?NDXZkO6Vq7SZhdmf+e+FqhwPHvuALjZ4iTF5ygvMwIISjhGaGDzdSOk/hSJ3?=
 =?us-ascii?Q?F2782GuQ9UDqi2gqQot7/XJ6GjmOK6EBRbDOvdPEulwYbnCdJR3j+5/rcmZa?=
 =?us-ascii?Q?Fg+43DZkAXx7HBnb+ZZOMWGW2GB7pwaNAyD1eQlyZ/sBmpALjYV5K8xFKaGa?=
 =?us-ascii?Q?2Ph0h0+d8Qm9GQljSCXLp9Cql9WPMQSEttBiVbShpyGKVrEM+2/ShfMRpKOs?=
 =?us-ascii?Q?ZTyuysTKLhGV/c8NuWjveo9QAB4b5pWewnYUDGupLlFkiWnFK5hb7CvO1+hp?=
 =?us-ascii?Q?lFSrfk5REPHYGxS8WDEjCruTO6sYHDO8IY3uNGjkENeQ+wDe0bwTc+C9r3E6?=
 =?us-ascii?Q?IixeNjjuoBk+PXXkE1846949SqXI7vB5rx86QXegCaa11+HEaGaPLW0owj5i?=
 =?us-ascii?Q?uod5kfupPoYALASexOVIGKwdLAZCABrqEMvE/am0/1mfej+VhPuux/ceFNTI?=
 =?us-ascii?Q?2QycE1jlZ9ShIVPWR7lQGknvsnz7/3s8ZoJ8aAGw0fRtLxBOIfw8FySPhi0T?=
 =?us-ascii?Q?Fd4jk74c4hIn5RyBllFZQu2qw5UhBtJmRVJhfxPdHpVI+9avn8wldR9RYrno?=
 =?us-ascii?Q?WevG0Am45+H4BwTGuRgosPuiXUSZ7U3ZH0QBFno2X4LBrlHkwZw3IaGrdWvQ?=
 =?us-ascii?Q?4CCoVb+e9oJbQ5SPvsc0N9E5RH9gzy5uSiCGgci5ARysvICCQ5WmgyDNJPm0?=
 =?us-ascii?Q?P8I6G19TDWsl0KkH6zOtBAbuMFaZBBGkphx0tIMP7+C4BPfXNebNQZ2O64mH?=
 =?us-ascii?Q?EMhi3uS+ifTcOGnj9m9FupzOJLT41qoOiQ8InPuU8w+KJaNiLPikQls9AXlZ?=
 =?us-ascii?Q?hTKsxWkWHfxXC5uqV7PKBgRg3D4fyEAuaHBZLo7Zwq1XF830a04djBps04MH?=
 =?us-ascii?Q?PA7V+FLXZdJImDXFvCc+dAToF+y/U19M/l8ZC2QZcdsJo/Jpe/mS4l3xw4x8?=
 =?us-ascii?Q?Vrq6e/3v4SNIPGwVDDe1r7m3BFHXPl2SzZikZiccPNe0HMJ0p6Fz0G6su41g?=
 =?us-ascii?Q?zjyfe4w+vIZ6XPIkxUpmw/1vusCNMMEyCis50eIIYBI31LUhngtAd2ItkJHp?=
 =?us-ascii?Q?Z8kOJq4iCSCT017XzAsFPHa6I53MWJ+1/8n7tMYd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5313d03f-f111-4cdb-671e-08dcf37857d6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 15:35:37.6960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bLQWyMDhJPzWoqVR109ZQx4IKYxRi+aftliAmXf3cPlyEiqbcIG40S6bZOp42RMcdX6KMu57Qa71y88hQlnLiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10651

On Wed, Oct 23, 2024 at 12:33:53PM +0000, Erik Schumacher wrote:
> The modulo register defines the period of the edge-aligned PWM mode
> (which is the only mode implemented). The reference manual states:
> "The EPWM period is determined by (MOD + 0001h) ..." So the value that
> is written to the MOD register must therefore be one less than the
> calculated period length.
> A correct MODULO value is particularly relevant if the PWM has to output
> a high frequency due to a low period value.
>
This is bug fix,  add fix tag and cc stable

Frank

> Signed-off-by: Erik Schumacher <erik.schumacher@iris-sensing.com>
> ---
>  drivers/pwm/pwm-imx-tpm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pwm/pwm-imx-tpm.c b/drivers/pwm/pwm-imx-tpm.c
> index 96ea343856f0..a05b66ffe208 100644
> --- a/drivers/pwm/pwm-imx-tpm.c
> +++ b/drivers/pwm/pwm-imx-tpm.c
> @@ -106,7 +106,7 @@ static int pwm_imx_tpm_round_state(struct pwm_chip *chip,
>  	p->prescale = prescale;
>
>  	period_count = (clock_unit + ((1 << prescale) >> 1)) >> prescale;
> -	p->mod = period_count;
> +	p->mod = period_count - 1;
>
>  	/* calculate real period HW can support */
>  	tmp = (u64)period_count << prescale;
> --
> 2.47.0
>

