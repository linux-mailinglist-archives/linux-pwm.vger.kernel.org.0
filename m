Return-Path: <linux-pwm+bounces-3689-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5639A0F72
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Oct 2024 18:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AFCCB211F7
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Oct 2024 16:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5548E20FA90;
	Wed, 16 Oct 2024 16:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bb4OWziB"
X-Original-To: linux-pwm@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2057.outbound.protection.outlook.com [40.107.105.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1534C205E23;
	Wed, 16 Oct 2024 16:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729095286; cv=fail; b=G1r38oBN5Jrpu1sjyLltjTfkM7NbK+rcTsBIaIY++FGz5/SQ1/bYiV9f31t9vun2GR2G/fr+2YVGldNpwZd5MnogFBUMIfZyf1xWOcPM3tftHQwPxpgzvPyOw+k19bwriAEtSqgvp0X2qY/IDr1dMv6Zf7fvLvh1FpBnGJdSvUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729095286; c=relaxed/simple;
	bh=GSaepaRPCDq0recSF1sw5xFfHkMG6JrdVod6Ki/mLU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=T87MYUXV7fwoKYPBy8BZS3XllQ1NPDFLqwHLadw4FJjY5z2HFoeRYpCJliFFr5fXPoM0m/v8HLg3oy0HmDKXV8LqT/Kv/Ld9nNRPKMfz0jLyHZOA/p5gEIvRqevC/jvfk0feu721mY9qGd6WJzk62xEx+BNynOctd4GgsafqCj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bb4OWziB reason="signature verification failed"; arc=fail smtp.client-ip=40.107.105.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N7Myvqjkq2fED4PKW62ubgmDbqX+ExU+fhR2sgHR1HmPanMAqynxv/uRZHm6SaPYRiTNQZNR9copTQL8V/nKlWLeILTo9DZiXG4zFwOnF05b07jynXiBAeUS6jvL32oSzWgsfdxRMrQVvPRrZoXG4iWJYArjcFPjdcney0oraSF82yBqoWiUJLeHbVFy0ZbHF932OWceeS/c9QlhFa+bMwNXRoVAgAvCzQeAGon76olKH8POO69OYlP9urQP3xTlpd2trbfwbrbHuNjlpmDOrzD0cvd39fU8g8SMs3BaFsoV2C03BrzlxX04gNod/NASuFNf0rTAWyfMyXKK44vJIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NR11Krs1qF147+lPZWp1lLCmio0aekXuZsRy9XrcQTM=;
 b=kNwgCRk6thvtiV1tbrhjBT0+5aHNfDXtr/HqjnjL21MPfSnXMrKC/8VWcGXcxi2i1Vt9d7zo9x3SnwUsJ6ndVcyLqS78m5hK6cOaO0oKIyDC+4N1FQkoUJcpwwOSfXHvGBafKFP2M+XR2UZ9g+xo5j8pffB+3WjRV1Ocxy0BAlyaobpJ+dv9EkSZkhg2Y2cZ68ssZwysf1UPuPPZ/IMMmQj5zN7A2tj9TRAGjLXsBGJSgREkmp1LuWyTnaqYw4ICMMVByK251o438NdSngOgEq+SgWSq5GuYrbX/nMg/BQR7L91aGjIwuwIZPoryKQWoF8mI0vvgTf8JuQIe72p2nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NR11Krs1qF147+lPZWp1lLCmio0aekXuZsRy9XrcQTM=;
 b=bb4OWziBzQbBOC5l/CMnRT/NR94lLePHAgK+R7IlCcZzh2vwj1muASZ3tO6OyxwdWWQ6SrxllheVCDk647sVcBceUcUfrE16BhFiEGaYCJOgT6PVQLrRr9B89XvG5m19qPfEx32GvJdPiac4SVNjFcLCKAHcVToKibW4EZ+yEiqFSNH0ESO9ZEw98EJNDnXP7tLnDQTi/TyBBRjNlYETBFbl1CGlV2PuoYgvZ0f2tK3yzON9+q/LHTAIVgM1Vn3CuIGjnFXySgspI8PJtvGFEyG+MgTDNH0RrKqBuF6aNPNBR781hFoUwRcXUFgypLZqxV/8Jxz7MvJzteEU+QEhTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AM9PR04MB8556.eurprd04.prod.outlook.com (2603:10a6:20b:437::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 16:14:40 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%3]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 16:14:40 +0000
Date: Wed, 16 Oct 2024 12:14:32 -0400
From: Frank Li <Frank.li@nxp.com>
To: u.kleine-koenig@baylibre.com
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, festevam@gmail.com,
	francesco@dolcini.it, imx@lists.linux.dev, jun.li@nxp.com,
	kernel@pengutronix.de, krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org, marex@denx.de, p.zabel@pengutronix.de,
	pratikmanvar09@gmail.com, robh@kernel.org, s.hauer@pengutronix.de,
	shawnguo@kernel.org, xiaoning.wang@nxp.com
Subject: Re: [PATCH v8 1/1] pwm: imx27: workaround of the pwm output bug when
 decrease the duty cycle
Message-ID: <Zw/maOfa12uoJlO6@lizhi-Precision-Tower-5810>
References: <20241008194123.1943141-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241008194123.1943141-1-Frank.Li@nxp.com>
X-ClientProxiedBy: SJ0PR03CA0135.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::20) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AM9PR04MB8556:EE_
X-MS-Office365-Filtering-Correlation-Id: be05e0ea-9f25-4e97-e4d6-08dcedfda393
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?mZPMHX3y/yGYOBQhYWvU67SFW4oWB7HPcWcrZCsChRqWyHjnAVYZAl0U3e?=
 =?iso-8859-1?Q?0++WAue73DJ85QYpvFWSu/YPjLMgT7hw1RE+ppadU79rbry2J+eHYzs2Qh?=
 =?iso-8859-1?Q?YkEcwzZ3hWdZ+Cs2+gHJ28iTl8ewocYM64XBy/nE9kV0cZhGe5+FMBsUEK?=
 =?iso-8859-1?Q?wV4p01IFcblZxcC5PwhUm5zM2cEgkJVDMy0VKiiyN7gGy/ubUeNW24PmTc?=
 =?iso-8859-1?Q?sTboiEXozyJsbnHCtYz48zXctFQFAg2CGN0Y8m1WBJt4oRzz+YU7oJcJoC?=
 =?iso-8859-1?Q?VC+UpxxF7fLUG05CCxbk+t1Kzu1fejqJExp8aaHBltelrGrA2WDbK1kXFZ?=
 =?iso-8859-1?Q?UV+1blnkWicU/W07zxOi4JpL9GiaYQE+1/C9VVgFiWs9rfhIEnU54xKSFB?=
 =?iso-8859-1?Q?WHS8ZMoSdMqHNGXkD3m69+3rRVenCi11KzTNeDbHsS8abcCi+SpERRGc1w?=
 =?iso-8859-1?Q?6D8Ppcn3DEa6he4DyijtQDE7f+r7I10vT7Cpb0NUDaXZPpwrmIg89Ztjll?=
 =?iso-8859-1?Q?sGrxMthNml93W3g7KC6xjlHytsVCT1ecf0NjDbqxtGcgQ+m2UKoe4yUlTy?=
 =?iso-8859-1?Q?qoHK9ukIeDQ8A+OAxm1iXLbbncGpLMOviMDHQWAfH5RcCOm7yWang45SzN?=
 =?iso-8859-1?Q?1efM7pQrNgb/crVgHivoIxrYAhNlnf8yoqUhoOF8jnqq6ekGcYQonAk9EX?=
 =?iso-8859-1?Q?d/DCs8tdePEjNkmU1RO2gMXNF51cuk22524n+KTdjSVV2G6p1M9rFZKr17?=
 =?iso-8859-1?Q?aDak/tHkb2KXmVFoJQytxmzjDZ9c/rzQGhWNkmHmzQi+/f6vK/ermtPuPS?=
 =?iso-8859-1?Q?wcy7VLPIs1RdWmfPd/dqCyDaaookRKm2i8SUyktothqgBRpv89HojcUV0v?=
 =?iso-8859-1?Q?iVoXka60sciqkkn6Fr8rhTVFurbN0ySrZXU69qeDpV3m8l8UU2EHcRTtWR?=
 =?iso-8859-1?Q?taTlsZHk27MIZAQwhBUvfvFuPHydDeMs4KMKLKeCV7KHmZ7v28riUjBIQQ?=
 =?iso-8859-1?Q?N3TmMoAMuEoJnAYSCAlTUjudTi9D16x4jFbBPyGT3U4WuZpKmNfL/T3Gl1?=
 =?iso-8859-1?Q?zZhp8iZWzk2SGHHM/cev7XZJi0YGqbT3aA/y3JuBGGgymWNt0z3FOSjqPx?=
 =?iso-8859-1?Q?aNiSOnCY0auHrlHyVmboh9PId1gIAKKRJle/kFKLNvRIcpF+9i4oes/OCt?=
 =?iso-8859-1?Q?OIvRfWqwVhYNtILr1HQHWJTJr39ogxzXyNwPyd8oR3QZ2jvvxnvzMzSSX8?=
 =?iso-8859-1?Q?OfeHISWItU5qiL0BgXja+Qj6WvJu5DMPg6uN+FXG/eeXWRmZoppU8KrJCr?=
 =?iso-8859-1?Q?YgASsyC0cz6gOaJTAWvP8YIsLuxSZfPYJLU0Z8eGHqW3jO6CbLm57p9Xo1?=
 =?iso-8859-1?Q?qSWIndYjG0HBdSrJHJjWXDjp83+VB9gw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?rCJKYKKu6fbn5AxubH1X1hDkq+QygQ7lXROTicEDOMeI3vQPI7yM9Mp1YE?=
 =?iso-8859-1?Q?Gw97y0VRwu9F2ZZi3JA6rx0TRrIDyO1oWEc4vi36Bp6a5JINe/PiYakEJS?=
 =?iso-8859-1?Q?KiwlDmZwSvvVWC4zqcppCZhWeXfdyd9Oc5S/uOMUs1mvDIfhB3Tnhj4r2v?=
 =?iso-8859-1?Q?9H7ni0Kl32xL/7KIh/NlWWWdRAOKJhz0G1tCNvy2F3fHj9NJhpyS6yN/jU?=
 =?iso-8859-1?Q?VVytsMo472/wov3V1aGOFml1FBBr5PZH4yZ6fqhfUCmzyK9U61Fb2V/Tke?=
 =?iso-8859-1?Q?37oFZR+2tc6fz2pcnD3DcDcWBCHZzaeyVATXUs03Zqy9Vd/3RgCxw0rfIH?=
 =?iso-8859-1?Q?a0Yl975Z1E4IE/Tm5E0eeCVeU2OPJJzBXmrpzOEPI5ws71APiCaa25TURu?=
 =?iso-8859-1?Q?QQBUlQ+AFIu1sEUhKRXyY+1q0Zb9EmM5tj6OfkfBlGCYGeKPyGkQmLwk8e?=
 =?iso-8859-1?Q?9KnaLWe14lqTPN8lcwdo+dhAcENEAGv8CLNVtgy6f8baWFgTg/xki3acRo?=
 =?iso-8859-1?Q?TKDbzFHyPzLuPkj17pvaw2/dbcUTdpCV8nxgVCF1MQukt4lLvgDoe/2weX?=
 =?iso-8859-1?Q?bjW/6Lf3xehMfR7WZZBKrcYrdBHZNfXQczuyr8E5V87WnAgSELhMpjt8t5?=
 =?iso-8859-1?Q?WNT0Jx7pG6MGnQ8PdapJSvjA/HUNvvdWgBYJfGjmF77EudHBeGXI7Xe8CE?=
 =?iso-8859-1?Q?3U6mCYapfB6zWdIPn2oH2vQyfHDZ/26ph+iK9qmBgVMs9xFKWJCK4eHPzg?=
 =?iso-8859-1?Q?LR8DBYUjDrnat7apj6+CdDPmRChL4RocSZisBCHjTWSSx+xalJA6SGS8fI?=
 =?iso-8859-1?Q?xm2zaWFimXZVI2fk4loInM2X+qSNjgCNv3Pd7p8AZvJsYqSYiVK8WVwwUl?=
 =?iso-8859-1?Q?jSpVFt5E65cNlk5R/tZBd3TSSKsBOm85Ek/yLhKHrhOP1KNIfL3r+o4tCP?=
 =?iso-8859-1?Q?+Zcebh7/Fplcscf0Ct7dxB4iQIGNtafxhNWdcJbtL2pYfXpW0JZHsgEHWp?=
 =?iso-8859-1?Q?4w+n9HYbUuCaI+PMLc43z7xA0Ac0wZAE+KEWceiiDNX30uNzEInpHCONkb?=
 =?iso-8859-1?Q?aBNN0OoTS4ThAH4GRAU91gtI33V+3djAi/kAFbcADlqScLWowu29FVT2pP?=
 =?iso-8859-1?Q?DJI9LToqrL0BeQS4rAYogqixu+vn1bHcK4lhoLV26y821BUyIInOBrYKlp?=
 =?iso-8859-1?Q?SAjpg1qN2wUI2rZxpL0VGCYs2CwqnPs+w+pdV9wq2meu3a1sEhTVp6g0J/?=
 =?iso-8859-1?Q?T8HznqXKfuy2mQ7YUpUWYxtUz89d63xn22YwFt7vKcXv/nfiyC7Q2Sz65i?=
 =?iso-8859-1?Q?923hN5IZqzty02sCnC9V4xl0+wf5SjkoHvzeobTbMs36dWgWaZawuJCABo?=
 =?iso-8859-1?Q?4KPWKZtv3DeoBz7qjbHYxZBo1geqBJAuZ0jUdnv9twrqBrRT8Yn1Q3WTsk?=
 =?iso-8859-1?Q?5cGf9d5bjNdtc9tYihV8vvLjsOwk4IA2amducYC6fwra0RcigQYQTeTmDg?=
 =?iso-8859-1?Q?6klCzMEJjcZadlS9dhRpKEgmVopi3HuvsOQCnh+1P/x59eQ/ntCS1UVPxT?=
 =?iso-8859-1?Q?arLRm+820crbGs97y7X6e7ahCobICFdhQbEn/ZkboUkop+S0AaeFF5tLwO?=
 =?iso-8859-1?Q?0qd2zYgpzUKac=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be05e0ea-9f25-4e97-e4d6-08dcedfda393
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 16:14:40.7769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VCDAe+XVRMmk+gAmqx06UUQ8GI45ULIdXHM/8RiCM3cPiWQGhFLOhhNKyeexKR763vH6JpKzptIATMKS2UXyTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8556

On Tue, Oct 08, 2024 at 03:41:23PM -0400, Frank Li wrote:
> From: Clark Wang <xiaoning.wang@nxp.com>
>
> Implement workaround for ERR051198
> (https://www.nxp.com/docs/en/errata/IMX8MN_0N14Y.pdf)
>
> PWM output may not function correctly if the FIFO is empty when a new SAR
> value is programmed
>
> Description:
>   When the PWM FIFO is empty, a new value programmed to the PWM Sample
>   register (PWM_PWMSAR) will be directly applied even if the current timer
>   period has not expired. If the new SAMPLE value programmed in the
>   PWM_PWMSAR register is less than the previous value, and the PWM counter
>   register (PWM_PWMCNR) that contains the current COUNT value is greater
>   than the new programmed SAMPLE value, the current period will not flip
>   the level. This may result in an output pulse with a duty cycle of 100%.
>
> Workaround:
>   Program the current SAMPLE value in the PWM_PWMSAR register before
>   updating the new duty cycle to the SAMPLE value in the PWM_PWMSAR
>   register. This will ensure that the new SAMPLE value is modified during
>   a non-empty FIFO, and can be successfully updated after the period
>   expires.
>
> Write the old SAR value before updating the new duty cycle to SAR. This
> avoids writing the new value into an empty FIFO.
>
> This only resolves the issue when the PWM period is longer than 2us
> (or <500kHz) because write register is not quick enough when PWM period is
> very short.
>
> Reproduce steps:
>   cd /sys/class/pwm/pwmchip1/pwm0
>   echo 2000000000 > period     # It is easy to observe by using long period
>   echo 1000000000 > duty_cycle
>   echo 1 > enable
>   echo       8000 > duty_cycle # One full high pulse will be seen by scope
>
> Fixes: 166091b1894d ("[ARM] MXC: add pwm driver for i.MX SoCs")
> Reviewed-by: Jun Li <jun.li@nxp.com>
> Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---

Uwe Kleine-König:

	Do you satisfy for what my merged comments's results and do you
have other comments about this workaround?

best regards
Frank

> Chagne from v7 to v8
> - combine Uwe's diagram and errata document.
> - use old period
> - use udelay(3 * period / 1000)
> - Only apply workaround when PWM enabled.
>
> Change from v6 to v7
> - Add continue write for < 500hz case to try best to workaround this
> problem.
>
> Change from v5 to v6
> - KHz to KHz
> - sar to SAR
> - move comments above if
>
> Change from v4 to v5
> - fix typo PMW & If
> - using imx->mmio_base + MX3_PWMSAR
>
> Change from v3 to v4
> - none, wrong bump version number
> Change from v2 to v3
> - simple workaround implement.
> - add reproduce steps.
>
> Change from v1 to v2
> - address comments in https://lore.kernel.org/linux-pwm/20211221095053.uz4qbnhdqziftymw@pengutronix.de/
>   About disable/enable pwm instead of disable/enable irq:
>   Some pmw periphal may sensitive to period. Disable/enable pwm will
> increase period, althouhg it is okay for most case, such as LED backlight
> or FAN speed. But some device such servo may require strict period.
>
> - address comments in https://lore.kernel.org/linux-pwm/d72d1ae5-0378-4bac-8b77-0bb69f55accd@gmx.net/
>   Using official errata number
>   fix typo 'filp'
>   add {} for else
>
> I supposed fixed all previous issues, let me know if I missed one.
> ---
>  drivers/pwm/pwm-imx27.c | 98 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 96 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
> index 9e2bbf5b4a8ce..0375987194318 100644
> --- a/drivers/pwm/pwm-imx27.c
> +++ b/drivers/pwm/pwm-imx27.c
> @@ -26,6 +26,7 @@
>  #define MX3_PWMSR			0x04    /* PWM Status Register */
>  #define MX3_PWMSAR			0x0C    /* PWM Sample Register */
>  #define MX3_PWMPR			0x10    /* PWM Period Register */
> +#define MX3_PWMCNR			0x14    /* PWM Counter Register */
>
>  #define MX3_PWMCR_FWM			GENMASK(27, 26)
>  #define MX3_PWMCR_STOPEN		BIT(25)
> @@ -219,10 +220,12 @@ static void pwm_imx27_wait_fifo_slot(struct pwm_chip *chip,
>  static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  			   const struct pwm_state *state)
>  {
> -	unsigned long period_cycles, duty_cycles, prescale;
> +	unsigned long period_cycles, duty_cycles, prescale, period_us, tmp;
>  	struct pwm_imx27_chip *imx = to_pwm_imx27_chip(chip);
>  	unsigned long long c;
>  	unsigned long long clkrate;
> +	unsigned long flags;
> +	int val;
>  	int ret;
>  	u32 cr;
>
> @@ -263,7 +266,98 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  		pwm_imx27_sw_reset(chip);
>  	}
>
> -	writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
> +	val = readl(imx->mmio_base + MX3_PWMPR);
> +	val = val >= MX3_PWMPR_MAX ? MX3_PWMPR_MAX : val;
> +	cr = readl(imx->mmio_base + MX3_PWMCR);
> +	tmp = NSEC_PER_SEC * (u64)(val + 2) * MX3_PWMCR_PRESCALER_GET(cr);
> +	tmp = DIV_ROUND_UP_ULL(tmp, clkrate);
> +	period_us = DIV_ROUND_UP_ULL(tmp, 1000);
> +
> +	/*
> +	 * ERR051198:
> +	 * PWM: PWM output may not function correctly if the FIFO is empty when
> +	 * a new SAR value is programmed
> +	 *
> +	 * Description:
> +	 * When the PWM FIFO is empty, a new value programmed to the PWM Sample
> +	 * register (PWM_PWMSAR) will be directly applied even if the current
> +	 * timer period has not expired.
> +	 *
> +	 * If the new SAMPLE value programmed in the PWM_PWMSAR register is
> +	 * less than the previous value, and the PWM counter register
> +	 * (PWM_PWMCNR) that contains the current COUNT value is greater than
> +	 * the new programmed SAMPLE value, the current period will not flip
> +	 * the level. This may result in an output pulse with a duty cycle of
> +	 * 100%.
> +	 *
> +	 * Consider a change from
> +	 *     ________
> +	 *    /        \______/
> +	 *    ^      *        ^
> +	 * to
> +	 *     ____
> +	 *    /    \__________/
> +	 *    ^               ^
> +	 * At the time marked by *, the new write value will be directly applied
> +	 * to SAR even the current period is not over if FIFO is empty.
> +	 *
> +	 *     ________        ____________________
> +	 *    /        \______/                    \__________/
> +	 *    ^               ^      *        ^               ^
> +	 *    |<-- old SAR -->|               |<-- new SAR -->|
> +	 *
> +	 * That is the output is active for a whole period.
> +	 *
> +	 * Workaround:
> +	 * Check new SAR less than old SAR and current counter is in errata
> +	 * windows, write extra old SAR into FIFO and new SAR will effect at
> +	 * next period.
> +	 *
> +	 * Sometime period is quite long, such as over 1 second. If add old SAR
> +	 * into FIFO unconditional, new SAR have to wait for next period. It
> +	 * may be too long.
> +	 *
> +	 * Turn off the interrupt to ensure that not IRQ and schedule happen
> +	 * during above operations. If any irq and schedule happen, counter
> +	 * in PWM will be out of data and take wrong action.
> +	 *
> +	 * Add a safety margin 1.5us because it needs some time to complete
> +	 * IO write.
> +	 *
> +	 * Use writel_relaxed() to minimize the interval between two writes to
> +	 * the SAR register to increase the fastest PWM frequency supported.
> +	 *
> +	 * When the PWM period is longer than 2us(or <500kHz), this workaround
> +	 * can solve this problem. No software workaround is available if PWM
> +	 * period is shorter than IO write. Just try best to fill old data
> +	 * into FIFO.
> +	 */
> +	c = clkrate * 1500;
> +	do_div(c, NSEC_PER_SEC);
> +
> +	local_irq_save(flags);
> +	val = FIELD_GET(MX3_PWMSR_FIFOAV, readl_relaxed(imx->mmio_base + MX3_PWMSR));
> +
> +	if (duty_cycles < imx->duty_cycle && (cr & MX3_PWMCR_EN)) {
> +		if (period_us < 2) { /* 2us = 500 kHz */
> +			/* Best effort attempt to fix up >500 kHz case */
> +			udelay(3 * period_us);
> +			writel_relaxed(imx->duty_cycle, imx->mmio_base + MX3_PWMSAR);
> +			writel_relaxed(imx->duty_cycle, imx->mmio_base + MX3_PWMSAR);
> +		} else if (val < MX3_PWMSR_FIFOAV_2WORDS) {
> +			val = readl_relaxed(imx->mmio_base + MX3_PWMCNR);
> +			/*
> +			 * If counter is close to period, controller may roll over when
> +			 * next IO write.
> +			 */
> +			if ((val + c >= duty_cycles && val < imx->duty_cycle) ||
> +			    val + c >= period_cycles)
> +				writel_relaxed(imx->duty_cycle, imx->mmio_base + MX3_PWMSAR);
> +		}
> +	}
> +	writel_relaxed(duty_cycles, imx->mmio_base + MX3_PWMSAR);
> +	local_irq_restore(flags);
> +
>  	writel(period_cycles, imx->mmio_base + MX3_PWMPR);
>
>  	/*
> --
> 2.34.1
>

