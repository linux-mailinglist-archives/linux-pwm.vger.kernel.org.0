Return-Path: <linux-pwm+bounces-3211-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A90A8975C6E
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Sep 2024 23:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A1932822FF
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Sep 2024 21:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB20A1885A8;
	Wed, 11 Sep 2024 21:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FR4uJh1Y"
X-Original-To: linux-pwm@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010034.outbound.protection.outlook.com [52.101.69.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C698A186E4F;
	Wed, 11 Sep 2024 21:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726090152; cv=fail; b=mqIPxyviW20SN/tkkMLDF/EQnsJVdFS+ZjXSrkrjBJ/cg8aubvHyLyW+vZxIC4japKVUF7lL6z0Yja6t7J70fl+GW8LOmUyq6nOPmzbOt9vded4GqwME+Dd/IVcee2QLwfWlvf/oRx94hsn1gKE9yNUCcT+SKoEn0ipxDtc7cRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726090152; c=relaxed/simple;
	bh=d2b1Awhw0pm6MjR6GthX2g/9uEql26PiJ8P9ijMVZiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Satu/foAOcjuWW5KRFHqEmoha6k9sHxyFANMce64LgvkLqDYbNjS4+gvmf/HpOrEuirNXNiHlP+Wg11TDlFdv3gA0U4lyOjfbJAdwe3jhAokZ+y1ztq4iMThAfE8VbFvFhTDl5HpORJvirmm4xUtp0uvsYF+zUxN6fd4L3eOyk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FR4uJh1Y; arc=fail smtp.client-ip=52.101.69.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J3huTE0dY3idyexWrY9EiY+0VZNou7qWBWDF0UwUXwsC9WtOBwjtxYBFtIkcmuhc4YZInAg8cXn2vfLP0FzBBUzkxAzrJH24TTfEK5tHx1hUes3Ho+xpunkgLIkjrwyjoH5PnLnvTz4m5gSg6hGZQ9yDP8a957rjnqqwZWzIqAurrDxW2lEcltTfjDAK+m0cdqkZI/nR9UnBP9u6WH2Qp96FgWCX8a0ovBaoiou7tfi0vP1lu0PaXj0jk/67+B37QfMQcYb1vTv69irct21tDsevqJKt6RQgxOoty6Ekw9wHuKgurLpP0FwIkYBmLtBEsXf2YDV2QFrJ+KBUmmMc3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KTyb5N3sxg3/3jTPjJb/giIiTG/VSvaPWeEGWoaBGGg=;
 b=KdAekpMTbf42SRWTkSALztcR06pKNJ0hWlQdK7ber9iAbR4Ya08Lc+NDQA1xC6YFBfdIr5pNLTbXdgGJvTouHSeHeAWPJaIo4oqG8KzjLBf6VUjmQXqoEjkDOeOFG02yHz7fbTXZ4h9S5ndJNSTlTYyuNUk25F6GN9qmc8UjuD13pNLs7yW9ow0/+eHEHYbpnEv+sjn0MwP3u9OZaaGETF4xryb7BaeBPnVWuJy+tacU6TYDl9C5WHHsS1OPGloR1eUqLGlbxEK3gK8ImfeRDjODYSALlZv+HM17yQL2p0lw2VLFq/R0MygNOWJdYvGoiYbI9Ol8XW5GxUm9A+2Vpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTyb5N3sxg3/3jTPjJb/giIiTG/VSvaPWeEGWoaBGGg=;
 b=FR4uJh1YVugbIqxceOdD5hQc/w0BkrWy7VmP8HhvN3IxgcHTtveNwOuMv6z0wHO0Cuecx9Sa28QtyR2X/NrPtIrX4ypgsEoovaIv76CkdGEM3AUI5u3vLa5MQA45OuQptYMEUdP+u42kvZoK6c1ytCzB0hnIlt2cjfE/54538zh8HTMEY3vvNbNsNPnRSTpX3IWqZA57rh5ORf7pXJ27VxiO8t45v2Ryy2U/ewKYypBHVh6JHNUQUBbinY3a61/s3/PSJ6MiyXMU1ranA6j60Y55mbRrMDsADFHPIz4VD3hoCNv9u0HnGzUcnSHFnjpE5wjeyfbumL4OoWXGqoVkmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB8347.eurprd04.prod.outlook.com (2603:10a6:10:245::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.18; Wed, 11 Sep
 2024 21:29:05 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7939.022; Wed, 11 Sep 2024
 21:29:05 +0000
Date: Wed, 11 Sep 2024 17:28:56 -0400
From: Frank Li <Frank.li@nxp.com>
To: Marek Vasut <marex@denx.de>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	pratikmanvar09@gmail.com, francesco@dolcini.it,
	Liu Ying <victor.liu@nxp.com>
Subject: Re: [PATCH v3 3/3] pwm: imx27: Add optional 32k clock for pwm in
 i.MX8QXP MIPI subsystem
Message-ID: <ZuILmHRO9rIXfxIm@lizhi-Precision-Tower-5810>
References: <20240910-pwm-v3-0-fbb047896618@nxp.com>
 <20240910-pwm-v3-3-fbb047896618@nxp.com>
 <40ecdbb2-8470-4e33-8a74-ccae6532174a@denx.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40ecdbb2-8470-4e33-8a74-ccae6532174a@denx.de>
X-ClientProxiedBy: BY5PR16CA0035.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::48) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB8347:EE_
X-MS-Office365-Filtering-Correlation-Id: bb34cdb5-f2c8-4fee-afd9-08dcd2a8c324
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+yfEUOBaIqX0xmSic4VO0qtVyGf8rBz7q8ZxfJSPDVfE6XDszqe4lTqqKE9Y?=
 =?us-ascii?Q?IP4ccd8T1yaMu0k/14LOxH2lVoOAx9vJo9pBuIGL984B9/FGiLYdepXjema4?=
 =?us-ascii?Q?dyg4AFbbs+Gh0iwvZxZ8c5aWkoTL+iJBk1rfEhv6Rh1sc22l4T/vBh67DBHs?=
 =?us-ascii?Q?W3NM8yKAUqxCK92CID8cHj90wrQzKXg2saQLpam7d0xCtKo3w4WuZf2TGBwu?=
 =?us-ascii?Q?VE1nNj0yuhUrugugBms+q8q5jBupMYn4pqcR0/AaXASVj2K2QFzCacIZYPB8?=
 =?us-ascii?Q?Z66EHXQdOqrKH/RDjYr6bx+U1fAyY4bi+mLOZHq0O7TeSCSh3visJdhiT+wV?=
 =?us-ascii?Q?Aw5VzBD5ZuOYcUnpsWjB19b50bgJQWfvkkTaW5+/Z4gt9RaPGBHRXR5OOhIH?=
 =?us-ascii?Q?OAweiQ24dvenD7/6t9vLc2SLdc6J4Oo5iFAzUz3HiTPRiL7fwuH35faW2Z2I?=
 =?us-ascii?Q?w2yI2gZNA15i7xLZ0rm+KlV2XxaWcCBlRC9wkLf7+j6gcu+9fRbESXsa5XMe?=
 =?us-ascii?Q?wW0OpnylXTCvxE8Ph7rdkfWooYONLSd4jGCs/RhcUmkWUJqG6fd36ifUom4G?=
 =?us-ascii?Q?y93Ky1iZV1ApY12Bkj3ItnWVMAPnDoGrLEegKPDwcnudxXAmRIAGDzTOp0PT?=
 =?us-ascii?Q?QJ2nBgEHzpYz3FuPO5c5oE/0VTrGQiUShMh8kZ4mP9hIED240pzpTwiql9l1?=
 =?us-ascii?Q?ykIaJg8QmONpepARjpaCVOqlppW+35HCH7C6N0/mAWOMe9628lbPic1flOfL?=
 =?us-ascii?Q?HMnpeaNL9GY5GbS8nNS1jiz8kBTisogY1EbF97Xkk8QTQc6mtZHrd2f2aGj2?=
 =?us-ascii?Q?C3il4sgcK1uZNfTivXaix33G2jr1Znr72grcT0nlN9ZSVFrnxJXGRNrbT6Jc?=
 =?us-ascii?Q?0TKfbx8aJojGaaTGMgCN04Dej4gH2WwvJ4cKZgPEqcD/K74e0UUK5uSPYzjd?=
 =?us-ascii?Q?T2h0p7yz+suUBghRyJbJau6YasEGL9khcJZ599FsOwLdfgGfTlRT2jqbcVLI?=
 =?us-ascii?Q?OmOApjNjipzF+tUYsGuQa3U4Vse1bkRIxX6hd/wLoouXSN8+txxz1l2fNPKt?=
 =?us-ascii?Q?rsLAZeHyq1ykT003ncxjNsmVF1oh5qE/KBF2vE1Ih8oqYLl3s94dqCFdR3TC?=
 =?us-ascii?Q?RztCn8TjGMEuduSyf1t/6lBfrGw3/g9XixQqomj7nEU/bk+qdMoWaCv+VFWd?=
 =?us-ascii?Q?CyMT6Rt9q6boBe/pXhKdgHjtPAzwI6OjEVo9Sk+neLaZjOOlfXymFNTeSRHk?=
 =?us-ascii?Q?waJ+3jDJ1Ds7znLvJ/EMPJQmO0gL7eTJyg8M0oXRRckvxBQ9dLX37ZZgHLxl?=
 =?us-ascii?Q?ax1MNwzOEbp0qhu8zDMHbOvLk7URlxl9rTuNo4ktVna7j+iojIzRE3iw1ijl?=
 =?us-ascii?Q?UCkPbXlkaTNZNDVYfQ/3HCHcSMMpFj0yokImqMOxGYxchxcKBw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dselCEM5w89crqvKzs+Q4efkNbf+A7bYQYtpa3xt5hkw1PLJ7JGoMewA7RlJ?=
 =?us-ascii?Q?TXm6JAaqM6f+wrOLz2/ej/o8HYwsUUktNaTHSwI/lKfXqFjt+ZjNV8+hoemw?=
 =?us-ascii?Q?TbKYdq81a7NuO9QTG2J/ZwAjvSlNTUnS3fvPbtk1hpIo1NMO6m9eg42KFUSB?=
 =?us-ascii?Q?SU8jWlAXppZsrpeCDNaiiW1sKUwyAbEdXkXRTYgSBfiH2FK1bNWl1gSVjlwE?=
 =?us-ascii?Q?g4RyN4Xm/gKFaIc9eoFzgeKtnvjKN6E0CHRimnSFP+zSyhzR+VNz2tQfHVNK?=
 =?us-ascii?Q?0tXOHGzP5PmsMBEirw+Fqt6AWzEFUv5KzfY7OtDXnZTTY6gSCsoySXH0KhLG?=
 =?us-ascii?Q?Xwi9EwRtP/oeH1IfEO8TB9Aro9zwKkpbwBLcHBjObXFJb1He/AUw2wk9x73k?=
 =?us-ascii?Q?vqkorKDcjbbEPlNeXjpTxHjFFIInIvNuMv5l0/2/DlNPvwYsGyT0eYFe7Itp?=
 =?us-ascii?Q?TcYHGKlePfn4mwd5xPjDqGAdIGd0P/ws/7ugl3JcJL9WamSy8HrN5002G/C4?=
 =?us-ascii?Q?wzNKLJgn0aDPNSFcDOj2Mn6ktx+7OTKw9UWjlDR9wT+VPP4kbAUBbckIZ16I?=
 =?us-ascii?Q?ZaBNvaXDdI4RCC/+1B5WsYzXfPSbNkjp4odDC1H7WJTYWp5hDm3oAE+/I4b4?=
 =?us-ascii?Q?K8m8vbGicve3xT50mpfmAJ7907Ls56IAqWJCCb6AWTPwYoga6lNBB32cXGcX?=
 =?us-ascii?Q?kW1BqAiYQLG4xciKkgIxkEfNrnqqshA006x3Tg+G6tISah7B20NSaGOOV7fD?=
 =?us-ascii?Q?wDDQZRsMQWXNqPVMH8s1pt3PdCSNpYQGaJQPb7qvvzoLrfjij/V2TVIq1YLP?=
 =?us-ascii?Q?tST4G6FeTbxM/oIPtchgCIdg6YR9PMn5ZeFw7kwVnhlrhinzGmQx6kh7cMof?=
 =?us-ascii?Q?fN88n6vsExqV9oqDVw0TdnNVOo7KBn+Kj4CZbB+a7ZxaGKLPsYCr1rUhBNX5?=
 =?us-ascii?Q?LoXsJtxwMB9PzixpF8hmDfBwuuu8ZRsXHVCesJnfweGHcTRfW4ZzIq/RgyN3?=
 =?us-ascii?Q?cVrHItYAtcrtUTZOvvb9pDyEKiDMDl4I5o+JKJCiWkEk1e85JiP+aMX+tzFG?=
 =?us-ascii?Q?Yt+TwYUK7KAyE56EdQV9m83CbfmCPuHWnI1fx+pzAfqZ2ojz24pX2pPkcvcB?=
 =?us-ascii?Q?48qHQQ8v9xlBzqBjVP5YyMXBFNJuwSbRkRPNMI7QKpFXIpKFzZ5C8sQEw+S0?=
 =?us-ascii?Q?xIWCnCIw3T+F6BKzZvSW0By2plewnDXhvgcdhC4a37QVHxbzvTy+c5dkRcmf?=
 =?us-ascii?Q?8zl3F1SOtzpDxRGfufrVqVYE5p87sdZCaqfI9gZk1bbrI3NVV90czkgRfPaL?=
 =?us-ascii?Q?gdTC0xxoc8S/ijziItlTbdFacCKRlbT2FlU1lXBHlB2eogtrBo08hebLQbqP?=
 =?us-ascii?Q?lXvtA4/qFF/+/DA6+EaeSfLG/MKsowYnLb6uzicDqujRNkWoEJU7+e5Fn3IX?=
 =?us-ascii?Q?l7vd5JrGSW2z70rwXoZjqgi4hZt0ZyRyo7N8bNuWxYbyI8k/C6Mk/pTAD8QU?=
 =?us-ascii?Q?jlIG76fK1GaHfQ7vJNyNRD4jlZU9mqcuALUwx0Y52lWBGy2rfZVRPSmj/Faf?=
 =?us-ascii?Q?QcxAUKFjdracfturkU8uCk4Oar9hVbjajU4OL2ew?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb34cdb5-f2c8-4fee-afd9-08dcd2a8c324
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 21:29:05.1742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m9UgTmuAUSTQ8kg9nCFCrhRczgQ2XUavvoOnF8sw0G9/Kn1I+Ig5FU7SMjMFMaUzW4PW488hV+IrGD3lOTHyqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8347

On Wed, Sep 11, 2024 at 10:31:40PM +0200, Marek Vasut wrote:
> On 9/10/24 9:07 PM, Frank Li wrote:
> > From: Liu Ying <victor.liu@nxp.com>
> >
> > PWM in i.MX8QXP MIPI subsystem needs the clock '32k'. Use it if the DTS
> > provides that.
> >
> > Signed-off-by: Liu Ying <victor.liu@nxp.com>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > Change from v2 to v3
> > - use buck clk API
> >
> > Change from v1 to v2
> > - remove if check for clk
> > - use dev_err_probe
> > - remove int val
> > ---
> >   drivers/pwm/pwm-imx27.c | 13 ++++++++++++-
> >   1 file changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
> > index ce9208540f1b8..2a9fba6f9d0a8 100644
> > --- a/drivers/pwm/pwm-imx27.c
> > +++ b/drivers/pwm/pwm-imx27.c
> > @@ -81,10 +81,11 @@
> >   #define MX3_PWMPR_MAX			0xfffe
> >   static const char * const pwm_imx27_clks[] = {"ipg", "per"};
> > +static const char * const pwm_imx27_opt_clks[] = {"32k"};
> >   #define PWM_IMX27_PER			1
> >   struct pwm_imx27_chip {
> > -	struct clk_bulk_data clks[ARRAY_SIZE(pwm_imx27_clks)];
> > +	struct clk_bulk_data clks[ARRAY_SIZE(pwm_imx27_clks) + ARRAY_SIZE(pwm_imx27_opt_clks)];
> >   	int clks_cnt;
> >   	void __iomem	*mmio_base;
> > @@ -371,6 +372,16 @@ static int pwm_imx27_probe(struct platform_device *pdev)
> >   		return dev_err_probe(&pdev->dev, ret,
> >   				     "getting clocks failed\n");
> > +	for (i = 0; i < ARRAY_SIZE(pwm_imx27_opt_clks); i++)
> > +		imx->clks[i + imx->clks_cnt].id = pwm_imx27_opt_clks[i];
> > +
> > +	ret = devm_clk_bulk_get_optional(&pdev->dev, ARRAY_SIZE(pwm_imx27_opt_clks),
> > +					 imx->clks + imx->clks_cnt);
> > +	if (ret)
> > +		return dev_err_probe(&pdev->dev, ret, "get optional clocks failed\n");
> > +
> > +	imx->clks_cnt += ARRAY_SIZE(pwm_imx27_opt_clks);
> > +
>
> This will succeed even if the regular PWM clock are invalid or not present,
> wouldn't it? I don't think removing that protection is an improvement.

I have not touch regular PWM clock's code. Just add more optional clocks.

devm_clk_bulk_get(imx->clks);
devm_clk_bulk_get_optional(imx->clks + required_cnt);

so imx->clks have two part {required_part, optional_part};

require part is the same as the before. If it invalidate or not present,
driver will fail probe.

>
> Also, it is not clear whether the 32kHz clock are really supplying the PWM,
> see my comment on 1/3 in this series.

Yes, it is for pwm.


