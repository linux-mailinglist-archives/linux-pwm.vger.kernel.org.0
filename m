Return-Path: <linux-pwm+bounces-2785-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B503592FCC3
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Jul 2024 16:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40489B20327
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Jul 2024 14:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70957171E65;
	Fri, 12 Jul 2024 14:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dXj/Z9xC"
X-Original-To: linux-pwm@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013071.outbound.protection.outlook.com [52.101.67.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2C615098E;
	Fri, 12 Jul 2024 14:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720795271; cv=fail; b=EwLyZANcM8E882BtUM4P2U+xg2THhM8C18uPUwagWfMfUMclCC91rgXSrmVVY8nwJ69N5YlREy0j3fb/QRuIxDsiHkljt3mEh+RNp6h6pf1iEndxXAYZyz2M+DgmpA88FZHmj4mlPMMllyj+vYS29QFm4JCvBMNzELGZ3yuFo+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720795271; c=relaxed/simple;
	bh=CUb70sCkQUFov9ql5SKGe6X0VR5ug6XpUBKLDLb7qx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=riLL8Ftgz4b21E/ugFgWUor8UoNfNXLgd3qMbSFk0leU0lLBQm4lqNzt2x0hx/tvz+IUTkL4pzAZNp+d0tuggbJD4Al0ETwfmimh5ClYminqn7acCcdQbs1GfcSd6AWUsQEITQRe4+QlGzbi43pYhBmRbkuoqQv3ZWiT82M024Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=dXj/Z9xC; arc=fail smtp.client-ip=52.101.67.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h2QuBe61JBqM+PBoIwwoWzUeHXcYv9AKP725019mS4Gc8TfBEZqeRD7323ZAO4vNNHGiwtdn2kziN/BxCkq5kSzVBGhFqwzOamlBh6InKP/eejiX01ppU+vOn6EMO/9Q70JQIXO/FkgecqqrQ6jljgG9xdYUREnyj4n0FWLQ4Tu64b7MLa8K2TRYV9KAajCHNs/YJBkUfWqYxXgbks/oQh/o0sj8k7cRhcXh0m1zXYQp9oAosia1KpnhkXPDj1BK+Jf+g0F4VQ/4Xqnu36kJZNs3OlzGRVg1ezsdySylBVRocN+xC9zw6VvsLD6jSZJHjZSRXCJ2b83p2AeC845CQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=16uwJvBijG4JkkW6J7u+mNO8tsjc/4SEcZenZKAvxAY=;
 b=eogUSaj2/kv2wo1eKVixXbIzUNNdP9D0CDJ50OLc8cx0BDoGd0RTr2Yg9aRL71oYVt5iPs4uS82D944JYTRQCbnT3/Cj+g2CuLZP6Smn7AgeKp0mcIw5oNZrQE/QbJ/SYN2suEG1zgYOt0v8mVofE4Jbk4Cy5rzpKTTa4eOPeD/2Vbwzxw5A/ls6SGgdT3jGLonN6KkcL8r4u5yFJcHl+RKAAYV2PDI2fCTMmNa2b90EFBsD8k2C0qHNsQ5iOCVYiKuH8aXSiSGXNV++xs3TwnytPwGw9eeFSHTc14fHhWj8MKZZEn+Pekc/YhBsk1DRVvJFwdDMeBSVbXascY3eaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=16uwJvBijG4JkkW6J7u+mNO8tsjc/4SEcZenZKAvxAY=;
 b=dXj/Z9xC393FyqfBR/Sp0XF0zZup/NN6eyaohuhJ9Kg3sp4XF3vK9iHSyc7TVMct8rFw9OKzynmVtCHPCz1VNQpP0hxMwkIM41IDxpT6q+qSG45CHQN1res4vyCfQrvzXc0AyPtYuMMvMVMicUtTVOKDvE7eywt7tRG0EB1tUTg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB9200.eurprd04.prod.outlook.com (2603:10a6:150:2b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Fri, 12 Jul
 2024 14:41:04 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 14:41:04 +0000
Date: Fri, 12 Jul 2024 10:40:55 -0400
From: Frank Li <Frank.li@nxp.com>
To: Stefan Wahren <wahrenst@gmx.net>
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
	Clark Wang <xiaoning.wang@nxp.com>, Jun Li <jun.li@nxp.com>,
	pratikmanvar09@gmail.com
Subject: Re: [PATCH 3/3] pwm: imx27: workaround of the pwm output bug when
 decrease the duty cycle
Message-ID: <ZpFAd+Mp2JFnaPet@lizhi-Precision-Tower-5810>
References: <20240711-pwm-v1-0-4d5766f99b8b@nxp.com>
 <20240711-pwm-v1-3-4d5766f99b8b@nxp.com>
 <78119193-98b7-446f-82d6-37884a5b03ad@gmx.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78119193-98b7-446f-82d6-37884a5b03ad@gmx.net>
X-ClientProxiedBy: BY3PR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:a03:217::25) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB9200:EE_
X-MS-Office365-Filtering-Correlation-Id: 07859288-5f26-4965-a4fc-08dca280a836
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S9jZ1QDOnHoNcH1GRCxVwnNsoiy9iDw+YCnMc6qkMV6C9BovrWn0rtx2cD7s?=
 =?us-ascii?Q?0Pg8Dbh+zRsg8JspJVLUMpp0A/7nlgrz7vuU10KxUl/7olZOo9C/NMYpeOdj?=
 =?us-ascii?Q?wgMlH2EHfpW79MixCa6OZj/rZECDdMv1hto3R2UAnNJ3tKDS2QNehcn2GXn7?=
 =?us-ascii?Q?YcuzF0ghuTWRQvKq6lZFaR3bACVAgVhn8grhpM2Jg7xyir1anYfhUrEEopgj?=
 =?us-ascii?Q?MIwLVWBKGwzk/CAeQ5eOBVpZZekV5WLtxmh5c2HgVChzKtqFumWEBbwtkbOf?=
 =?us-ascii?Q?nRykdTpuGkHVgJScrZf97Tef4+bkWVyTRbUErk2OST3Ts7GmpZG8M59DVDGH?=
 =?us-ascii?Q?IqKfEAG/NFg4iBkkdSCtqM9W/AUiRAokBulpdp5HL5LhBBxnnLtQOKfNd9nT?=
 =?us-ascii?Q?Mn8SWCXzMZf9dSdikTJ34BKnfHNNv8iJUKOIACEJB2g1iEp6cyEYNgmEi79s?=
 =?us-ascii?Q?+KzgMzhpM5mhsKI8NkDoRAb/ifl9sGkt8ORZiksMoiAwgRBU8WYzqP205OVg?=
 =?us-ascii?Q?ewmEhI7X+mxtwiIJA0Xk/kt85I++VIMiGUK6UsAon8mj/VcAlsAsk3GlULVU?=
 =?us-ascii?Q?n+TeSCAAiUCUtay8IKBd4WOQSGkwhEM21cfRZPZnVAnm14h+/AExRicKCrHc?=
 =?us-ascii?Q?rDqdGFv3oOyk1uPjJPX9dtLV4Lnns63ToU7Vgod950lQ1rkMb3xdwmDwefiA?=
 =?us-ascii?Q?BtYIPKsO+6wY/XAf2BpGpYKQsIy2/eTTC6R6K36iBeIUxvFOjz91FqDGiVvY?=
 =?us-ascii?Q?Y1ama8NdX2Ou/Ta0Xl2Ob3Ayp3BMDk3rTNgVn08OgQYfTXLz0ksEB/EaEgwO?=
 =?us-ascii?Q?nnFlYNprCV7Tf3HxSoRzvg2kxbZJjf2QytJxYxhHcSjWr8MNurHAasx32hAR?=
 =?us-ascii?Q?0EuimPwydJb7INAx9OgBEEuRadg57Cz1xK23LtnEr8c6hirWsnyfAFJMkqkj?=
 =?us-ascii?Q?NOsLSOs4mBSZ9fxqaz3p3tkT9wmEDuOZylJe33xidcRIH6ECyw6wz8iLKcyQ?=
 =?us-ascii?Q?HWZSYVYjca02DABrkMB9RLiWFcp7pG+LVPVY5jk7r55Yp4SP2g04AOTik3br?=
 =?us-ascii?Q?xCHQrw79ADCpB2CUZid+1K34qRyfzwZL0mvlxG16UoLevwPz+Zzfc/TEsdq2?=
 =?us-ascii?Q?ZrOLtqoFVcUWvcVbXVOhQSpINHmfQPz+Bp/+JVIcma7xHA+XJ9keMA8t2QWn?=
 =?us-ascii?Q?FLFpSIZGKBPcRSI1CWTl9gT++1lvDBrlyPbYTOv2cLy5+AMDw1MwAmVIXIFm?=
 =?us-ascii?Q?oN7N4J5T+wWcoUY/Yg5k0eG+ZgWqnhPekRHZ3Ds/TP3Zk6TVU4vlj7hD8xSP?=
 =?us-ascii?Q?4fchw/yKvWVAIThSuWUFxBxB1pbejSWpqFqdX0FAsRQxRWrooPvwEi9seqyk?=
 =?us-ascii?Q?5ku7aBA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AYiTTQ//K3kHVQMaELdVCR4082CXgtDPSvrjRakwHxe35o3Aa0YSiyWxYVB8?=
 =?us-ascii?Q?yHEKQ9/Zg3in03352Cq0yHSDnwAjTsRQSwbziOgdczV+mcH0B9fb0GgPePAB?=
 =?us-ascii?Q?22u8jQeX5lb5ysZNXOzMQmKiz+TpZr/jTTDkSOBH8mGnlkq/Em/slYVn1s8H?=
 =?us-ascii?Q?70j2o8xaoYiyptXSM9/gh3FfLgvDHamMdxGmCPreMpvmRIfc+6FxW0ZnAwhz?=
 =?us-ascii?Q?iEUgbj0EICKNG2gc48TkisXtZp+Ml0MokpBwUfzr9eoKD8fFgnL8tGweTTsT?=
 =?us-ascii?Q?q0mkPgkxTDZG8D7kfWNuYkSW2HOsnb6Y3yPDyRGIs35GJjlKXfo/p30Uywzl?=
 =?us-ascii?Q?cOyx3BUN+Roj1gseyUBQtK6XQwwblnQc8lkS4GYZExasUyfcyaz7x/bw/Mmj?=
 =?us-ascii?Q?pD5b+0DllwnXR0jh7VVAJ0RW0RTPYRVLcP4PCmXX39JZaw0RiUtKr9Ll+v23?=
 =?us-ascii?Q?Eg39Y/EbaDnaiax7f41FYuShZQQKKk3BdJ3/FhXj/TsVYWmNBsurz07oe2Oe?=
 =?us-ascii?Q?Iyc8rBSA4mGGUbfFOuZh/ydDbZ7vLqUm3EIJE9qQFjzvfTj90VbJi0RKsUIn?=
 =?us-ascii?Q?5xQQrnRLVYKjIzDUb7g5ozRcbJ87Il0oc7BcMhI+VxwDmRwT6sl05h3MDOan?=
 =?us-ascii?Q?gy/h6cW7aNEcMt0KB4ri7E0+fonx6JTRnnZ0eBH1BgPMFQcuIyb48Ys5A0oc?=
 =?us-ascii?Q?ncwZFCiv61YF/3SAYQifTApbG1iLmEhFRLTgfDMv8MMen1DpTIyvTcRVgkL7?=
 =?us-ascii?Q?I3mQxqzjogGHg8fIhHS3TbzWz+kRZgmLknBSnS23i4tLgWROWPwRHM736bhZ?=
 =?us-ascii?Q?oqjr//m0mhmBVTDf3zY5e+hVV/ixAJ3P4gq3LOjAksoXNnLgbExyH3m+TPPh?=
 =?us-ascii?Q?/DEfzpw4HaiLwef4tsjbFIuG/L4nZZUr+4ZoA3Enz+gUrSU1HoMVGiEaz3Np?=
 =?us-ascii?Q?vJdSr49+RjtHMUvFmJNoDYa8p4YkJXuhtF541doF/nVEccN70i+X6i3BsjV9?=
 =?us-ascii?Q?t8Eq3Ubfbe97zE2M02J08n1vxfSNnONwV5wsrgn+lo1Ab3YnKOWjQsMUEZpD?=
 =?us-ascii?Q?ZzObKEoeXs3NlNb1C9NoCTc+Z6m0Q1CSPgr7PRPrcOgThf+4TYX7Gyk4pJqf?=
 =?us-ascii?Q?b7evpnUDTj+TuU8026wWSm0gocgefVm8rfdWki7fhw7dJ8pwhMtvI++lOpU9?=
 =?us-ascii?Q?A87AquNPymU21a4PVHqs6kZl6RncpJJXxhSBVAqY/gmRWyVhT4GgYSTceLqN?=
 =?us-ascii?Q?ibS3rPUFImPy/UDsPl5sSf8rNkgfuQ3Q9CSsT8nzrT73ZMKJzZn3y0GEMFVg?=
 =?us-ascii?Q?j1/SFInRIm3urP5YEwWp2b6H9u88HeYrikCxacTPx1KFkBItu7D0vBgfL7If?=
 =?us-ascii?Q?e3xWOAQV8vdbcd8PYugfSUKUHoQY7ktL8KOfjssXFkHeHoF97i9HU/yPWqH5?=
 =?us-ascii?Q?u9y4LI0QJ6EiKFVJByZ5WSWi1PxseuJQ6nCiOTJEifHDvWgF1oze3+0l5Xhq?=
 =?us-ascii?Q?BE48ZvbYImeUWVuXgejnZ5xsfiLVfKFTHq9tDrudSAlEiAMTBv3hwPaBKxHe?=
 =?us-ascii?Q?NV8nbqEadqMZ026w/SkWUN6Mb2S3e5IA2FzRUxf6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07859288-5f26-4965-a4fc-08dca280a836
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 14:41:04.2510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7y4yIMf3QN8R1bHlB6sielENfRpD3tXyt6XTPONbwV4L+0CcGZ+MCRfRneucm5+cwL48q4T548x8KRVxsEnmww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9200

On Fri, Jul 12, 2024 at 08:26:17AM +0200, Stefan Wahren wrote:
> Hi Frank,
> 
> Am 11.07.24 um 23:08 schrieb Frank Li:
> > From: Clark Wang <xiaoning.wang@nxp.com>
> > 
> > When the SAR FIFO is empty, the write value is directly applied to SAR even
> > though the current period is not over. If the new SAR value is less than
> > the old one and the counter is greater than the new SAR value, the current
> > period will not flip the level. This result in a pulse with a 100% duty
> > cycle.
> > 
> > Write the old SAR value before updating the new duty cycle to SAR. This
> > avoids writing the new value into an empty FIFO.
> > 
> > This only resolves the issue when the PWM period is longer than 2us
> > (or <500KHz) because write register is not quick enough when PWM period is
> > very short.
> > 
> > Reviewed-by: Jun Li <jun.li@nxp.com>
> > Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> the same patch has been submitted from other people in the past and they
> received many review comments [1], [2].
> 
> Can you please explain which version of the patch this is and does it
> address any review comments?

Thank, I am not realize someone already submitted before. I fixed some by
common senses. Let me double check to make sure to fix all. 

Frank

> 
> Best regards
> 
> [1] -
> https://lore.kernel.org/linux-pwm/20211220073130.1429723-1-xiaoning.wang@nxp.com/
> [2] -
> https://lore.kernel.org/linux-pwm/20231229063013.1786-1-pratikmanvar09@gmail.com/

