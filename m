Return-Path: <linux-pwm+bounces-6524-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B14DDAE75A5
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Jun 2025 06:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15B4B1745F1
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Jun 2025 04:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DB51DE4EF;
	Wed, 25 Jun 2025 04:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WVR4Amzb"
X-Original-To: linux-pwm@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013023.outbound.protection.outlook.com [40.107.159.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B74AD58;
	Wed, 25 Jun 2025 04:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750824297; cv=fail; b=SoBLYtermCGSuhwjq65y1AUYojCeicohVMSI9kLwZ+y3ZpeNjsOLpHjCSHYRmodrK9fQLlp7U3w9Y51B0xB6qiJtx11URV1xNPcywgx080SBgEgImaInp4I/5LNwWllQ+nUXicq3GBrGLxf2Qdupwqn5VhEelDVypVsggW64nuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750824297; c=relaxed/simple;
	bh=S+3F6WiuGJ2O5dQhDqrs8gk2d/5vfp9LrnOd2rEpEAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sxzy2WjxBQ85/aEaR8MHiMfHPqAXUVXI/eef2zVB2DPlw/f/5r6+spvGQgG1r7SRSBXH5Inml/mpF1OaShkKaEjK8r/1Iy0P5YqCOEdTMPjLuDgCDC68hjmBdOLK6kem3mNHCu3ztoXlZZEAT14aQrNYknWCQHcrkSf1wPdOybM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WVR4Amzb; arc=fail smtp.client-ip=40.107.159.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T4juAh/bd8wY24xFBcYB21nF8uzLeQD99MlDeVxsYFBzayvlywoVjwzR6sXhnvhnluLE5cUuMtC9hGDQriTgYCC7s80Arm9vxoy5dmkg9KrwVV4yd1XPtV8z7nr6aTfhK83YQxsLqHZvN14qj4wlRM5OFveNn4c7os8ypkjn8SUH+nyOICoggzeOx0ICbIPIxEUmB6iHCPpJg8jyDbWB458pooiGKkVXoH82btX8wqdUXIsVuQbDLzfVyR1DTTZ6eW2s2LLEZh9GMti+K0VTOsOfoi6GSV9XeyQOVYKc2syuOP5UvPy45c3tDr1SBUAwzUYPJJ795VawP7/EIbbcsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/mR6dhMCAE/SfQ1BXR6tW42y0wFv+7n0w3qtBS/LRoc=;
 b=QJbhUjnah6fOqN67BeWX4IlP8M9GXso3Gv2L7EJBl/8uYE25u/+c+Pwbfr7byurgmB80L8ao41R/SbEAD07n1Lxb3OvqgIVP5Ml8EORgzZgSl8bxsss0pwnLMOUGrBMKwX0ZK8C9EN0s+b9jJPEzk5DE1fkrBVPy7QfIaJ6gsIXkCZDMxi9C+m5NwtXlThTYMtStHYqjyvTJDIOcoSfVV/sE6rjBkji8q9fYb4v54sicr0vDTDpmV7v8c015dqOVY7WchS4wMcFzYm1hlDWD9VOPTL05AWgB2IBllzKxUDJfD8+pNsvSNl0FGqga8N0HxP/KdR1Z5o4bF9CuggeVaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/mR6dhMCAE/SfQ1BXR6tW42y0wFv+7n0w3qtBS/LRoc=;
 b=WVR4Amzb9/Y2kTPF5JyfshCDS4OoHCRUheN94lgVV95zCWlnfhOPCnUhJf2ikLgZOwM9OnUoNGfVbi2PxpIkqd6TUA2yCVYXyIbO053wd9zYVNrxpud54yCRaGXs4nGeAVzb8KTaEfGoUbumS33huR7Rs9UaPteC/EaQp5Uk0hLoAsN9TyY6Dy/BoQL9KrmxuSrslqigYbFlA9DegfBq6JOc4hDktNfSccUB1ZLolSPLs66SjxC682ulJHYkxOqGBGEm4eg1FWAoou9CBEsjgq5cwQtesuxef8YJK+zHx1jUp8aoBduI5Qv1ZfQ+w21D7kEqPC1yNvuwl5bIpw6x6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8889.eurprd04.prod.outlook.com (2603:10a6:20b:408::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Wed, 25 Jun
 2025 04:04:52 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8880.015; Wed, 25 Jun 2025
 04:04:52 +0000
Date: Wed, 25 Jun 2025 00:04:47 -0400
From: Frank Li <Frank.li@nxp.com>
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	"open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"moderated list:ARM/LPC32XX SOC SUPPORT" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: pwm: convert lpc32xx-pwm.txt to yaml
 format
Message-ID: <aFt1Xy0s8rF/CHz4@lizhi-Precision-Tower-5810>
References: <20250624200955.2514896-1-Frank.Li@nxp.com>
 <94e42d9b-fae3-4e3a-a72f-dc284d0b4abc@mleia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94e42d9b-fae3-4e3a-a72f-dc284d0b4abc@mleia.com>
X-ClientProxiedBy: AS4P189CA0006.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d7::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8889:EE_
X-MS-Office365-Filtering-Correlation-Id: 84d877dc-110a-44e4-a8ed-08ddb39d6f82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ixXcY6JDNqAdAnSnzqj9YrcsPt7YjW0W03rvHY+nHbWUtyCBy1awm4PxjI74?=
 =?us-ascii?Q?rTj51i2otk2Pnco9V5JuqZwxmePNbt1My4VWRaSfciGwC/Pbxr7aaskcaJLN?=
 =?us-ascii?Q?EY6KhvEoOUT0TYEeRlFSJGOOeta/aeNnLSLhbDreKJ56p7KrGPKaJ5MsF722?=
 =?us-ascii?Q?uezP2fCQ5Ah1WoqFi6BFEJYTXjTJPQ83+vir1xJ0bU8zOrkqJttQTio7Ivsv?=
 =?us-ascii?Q?Ttp4oCBwM2TR3YoHzKGZZD0uvLDgbXJqYmANs+Q1VFIKiemi0CxFjVpcC9XZ?=
 =?us-ascii?Q?mXoVARGprto+k2RyuFpJUzosnZXbpEKUq3E6KiIa0ynaCSTvih0uy7l5n8MG?=
 =?us-ascii?Q?gz2yJFR5i7iBEVLCSZ8Zi6uuWiFTa7Bt+qgnmXZW0bstFzlYp2zVoivXiuO+?=
 =?us-ascii?Q?NWswLrgMO3Bter3qkV3YwEgB+x8E9M+i28e8j0Ag0zM1VCM2oXrjPJ65Si5x?=
 =?us-ascii?Q?kaekGPayUo3t2cSwSbxGc/8rwQMUXX3EwFF7RFXRzpRCSUEW/PVlcyQ9Ma2V?=
 =?us-ascii?Q?SYwsM9dkMEb7KXWBDZemUglMYG9EJsdN3bysWdYUjqhDjdHIGWcE9PASMvss?=
 =?us-ascii?Q?GZJzw2oaUY/iiwRt9iu7FcttiKKGy/SxqPyrNjep4hoZVdqY3gr/N6JMRxwy?=
 =?us-ascii?Q?gprtS6CNr6Cm3z6wHFzDgB+Axw8DPL+krJqpwbJgBTWtvqtKxhj+EFhHE801?=
 =?us-ascii?Q?SoieLZt0X/1NaZeEYNhiIXpvSof92cnZSIBl60hN0ZYIQh09lMfbrwdrCZRc?=
 =?us-ascii?Q?uu/Ss8lZExiOx44L+Vt53luTT8VPSO5FJk4KmIHHrKUHvOh27GpO2jUQIZ4y?=
 =?us-ascii?Q?W76IG3h0eor01S0E5nWx2oI1Jlao7RxnCCn3Tf1VEnc0/imym/LhSXhhF4Mz?=
 =?us-ascii?Q?uEI+OXTKTcOoKo7GSQOJ32kRgbIN14gdjdI4OF6Cr/V1VKqPOs32WmotgOsl?=
 =?us-ascii?Q?nRW+SBQG3p4AH5P9k9BMAMQpm7N/V/2I2DMHiS22p+YJ5d0mvco+KvvyyHc5?=
 =?us-ascii?Q?4BEEOJJxAhto2N4PJUdCO0xQMoPK6z5mLOBV0VCA4G+axPfuWB4TUth69DjL?=
 =?us-ascii?Q?M/B4UvDe3yWqmPeS2p4OppAaqnjna1+kHFtsPX2cU5FVeNENiWrbfDV79k0T?=
 =?us-ascii?Q?lom9Dl8Klm1LrtWw0q+YL0X1Ivhca39FO0eciw7J2BQxGJa1ifuYFHDLudMm?=
 =?us-ascii?Q?Nwop8sOlVpY7OpFaWQjQxkR/bjAQ+oOiEBgauUyRY3XBmAoZAXKBiOHxt3l6?=
 =?us-ascii?Q?IMp+/3yHYRHWaIwgk0tRcvgf4McMXljqVU14mE+7ZGnlXE0DTtxLMjHvJi/c?=
 =?us-ascii?Q?AE9yftHRPsdE2AOWjzuGHPoer7wB+4cRzaPcU99JZH0BWjMe2Csd9rupWROc?=
 =?us-ascii?Q?cqTiGR2s3LXb1K30k+V/IJmD7o9DdKmHJ1MeVVw5LLi0OJQ+CRgS7oMDKYRi?=
 =?us-ascii?Q?JlA+PmxwfA0siEbwntbQDDr4MBLNQNAs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cim9khwZVvg4rXsPTI3Y+nK4v6MnZfGEPB45da6zuNqVaOzIwYdM5Yvs8dOh?=
 =?us-ascii?Q?Z/dmV5w9D5lr/gdHcErKaxbzAZz1fXl/lpo+ALxTRB4hS6hPmDR+4xbgUnOk?=
 =?us-ascii?Q?gWWIQc6v72t2rzP2l4A/60gw3dycRryNWs7sKL1qMGJ/UJDW2Z+dtErpo6h6?=
 =?us-ascii?Q?KbhOIVJhaAWcdGgeo0ZWYLJT0Nn4f/SoRYPumEtpK0NKF/PagNk58jVmcDiP?=
 =?us-ascii?Q?9pc69mMCmpsgtPzbbnLOfn1CMisDIOEB21X+kaagZ33wNhwUoZwMKu1tcHzz?=
 =?us-ascii?Q?QDlJs6/qCWpfZbvAEF0YCPN2lo1O1bv+8/JWhb3YmIDYVf55uYHn/Uuvtp5v?=
 =?us-ascii?Q?jZw5ai1aqRCYQfU3YE1yA+XIqp6UgVzlv9+7P7BUSYWgTCo7VIvTJuMhRTL8?=
 =?us-ascii?Q?CffsbFugCn0lUEEsHKKKaozRbBSLawdeZpjJxOrytwtlPKIKYkyZsm60dG1s?=
 =?us-ascii?Q?9/huSmrrljxz+e4q+Av4SbSpeCwUQrZ8XS8gi0TUzNO1mRHoDPQHmp1rTN2/?=
 =?us-ascii?Q?hzabtgS4gRPq2+j/SqW/TLAyDEIDkE+3fW+UIYUDVbq9hZJWCBEWw2xKyuMj?=
 =?us-ascii?Q?BadYf5KGxfcE0eJMGuVgu+PGc047e5F1le9ReM4bMuwgNyIGg/lyLAvECQi0?=
 =?us-ascii?Q?xYlbm5vtt7W8LtX5rmTOflpkVPtLkCJXuvLEmUD/CVPXral5zYRaQd6tOm19?=
 =?us-ascii?Q?Gk1SikU1U9Ww1J5f+f6hBA+FyWlCUxY1OkgzuP7S4567YOuxBvT518mIfqSG?=
 =?us-ascii?Q?/OscibUEBP17248Bg9nvcw4MYTAN5tuIe1h9ng1MvKan7R9tHFeB0i1T8TCC?=
 =?us-ascii?Q?xzdTUI6geSwPwywOWO4e+Dw7SMACdCbO3eNwmMWfZ4THH8CRiStz5v4BEZN8?=
 =?us-ascii?Q?IND/xPbt1xTNJ8g343QGbUgN0FE7xyAHeLn0IhneLvwPVoPoeVVwBFDEtFHv?=
 =?us-ascii?Q?t+HZbGYFBf/qqzR8/F3M/fKuEk+MfNxLe15LuScq/GCJT6FhGc3clWNNeyas?=
 =?us-ascii?Q?MWaqxd7ooYWYJHIWNFQZVyuhnScwH8GQgqO9J7iWSVeCn8CHtUsr4IXigAqT?=
 =?us-ascii?Q?dQG/79m5njGAHLnse9bgF3+glODJq5kk8PjjTyaTR00azIZ/6ExbULN4rT5R?=
 =?us-ascii?Q?V0/a2D/+aT7UhgkQUGdGZQ3Kd15H7sM/GabruUgD2QIkK6HgXven75QqyAzx?=
 =?us-ascii?Q?9W1QxWaos+A0fX9qa2d8/KtLdiBmfx+WUPbxRs/iWqED4xhTRJ49zkppDxfC?=
 =?us-ascii?Q?CwC0cRgygFLORSDh/I/huFZKoIoIhZCk9Qc8WMSNRrKrCguCap9uyKGuPqdh?=
 =?us-ascii?Q?t0AgwZkCrOySwAsUyja7IY/s0Sazn+llI+cXr4NisimIzXxyJ2FX80Mu4T0J?=
 =?us-ascii?Q?5PEj5BdbD0PBvu0oD3Og4duys7K/eIFDBx3eeVE2ehNX2TPr/BTOOPLPcjDu?=
 =?us-ascii?Q?v6V5VpwH6Z0RBJWRvYMFvaYQAaUe076vUODB1tPoy9LMGEyjZAgucify0jxt?=
 =?us-ascii?Q?Zi9GOZoVCo/HNTWzER+Tf9+UBg7TCw29Pbz26tpWEfYr3H5u3QQB64RzavsK?=
 =?us-ascii?Q?tEJYe7A2z1AVa6yA5Z0+vanjilggOrxUECA7nd4B?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84d877dc-110a-44e4-a8ed-08ddb39d6f82
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 04:04:52.0757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uOddZlEIDsA0kIfj/jCG6J3tUFsPW9lY/a7A+VPKOcrIbdmQKYSJnA163jMM/3Sm8DvA1u5pxyIB6PDulz5GAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8889

On Wed, Jun 25, 2025 at 03:37:49AM +0300, Vladimir Zapolskiy wrote:
> On 6/24/25 23:09, Frank Li wrote:
> > Convert pc32xx-pwm.txt to yaml format.
> >
> > Additional changes:
> > - add ref to pwm.yaml
> > - restrict #pwm-cells to 3
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >   .../devicetree/bindings/pwm/lpc32xx-pwm.txt   | 17 --------
> >   .../bindings/pwm/nxp,lpc3220-pwm.yaml         | 41 +++++++++++++++++++
> >   2 files changed, 41 insertions(+), 17 deletions(-)
> >   delete mode 100644 Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt
> >   create mode 100644 Documentation/devicetree/bindings/pwm/nxp,lpc3220-pwm.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt b/Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt
> > deleted file mode 100644
> > index 74b5bc5dd19ac..0000000000000
> > --- a/Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt
> > +++ /dev/null
> > @@ -1,17 +0,0 @@
> > -LPC32XX PWM controller
> > -
> > -Required properties:
> > -- compatible: should be "nxp,lpc3220-pwm"
> > -- reg: physical base address and length of the controller's registers
> > -
> > -Examples:
> > -
> > -pwm@4005c000 {
> > -	compatible = "nxp,lpc3220-pwm";
> > -	reg = <0x4005c000 0x4>;
> > -};
> > -
> > -pwm@4005c004 {
> > -	compatible = "nxp,lpc3220-pwm";
> > -	reg = <0x4005c004 0x4>;
> > -};
> > diff --git a/Documentation/devicetree/bindings/pwm/nxp,lpc3220-pwm.yaml b/Documentation/devicetree/bindings/pwm/nxp,lpc3220-pwm.yaml
> > new file mode 100644
> > index 0000000000000..b82d52f583df8
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pwm/nxp,lpc3220-pwm.yaml
> > @@ -0,0 +1,41 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pwm/nxp,lpc3220-pwm.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: NXP LPC32XX PWM controller
> > +
> > +maintainers:
> > +  - Frank Li <Frank.Li@nxp.com>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - nxp,lpc3220-pwm
> > +      - nxp,lpc3220-motor-pwm
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  '#pwm-cells':
> > +    const: 3
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - '#pwm-cells'
> > +
> > +allOf:
> > +  - $ref: pwm.yaml#
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    pwm@4005c000 {
> > +        compatible = "nxp,lpc3220-pwm";
> > +        reg = <0x4005c000 0x4>;
> > +        #pwm-cells = <3>;
> > +    };
> > +
>
> "clocks" and "assigned-clock-parents" properties are required.
>
> Please fix the old .txt scheme, or the new one.
>
> I will have to NAK any converted yaml file, if there is a clear
> difference between the actual and proper description of controllers
> from lpc32xx.dtsi and new proposed schemes.

Sorry, I missed squash local patch. In my local branch, lpc dtb check
warning already reduce to 0.

Frank
>
> --
> Best wishes,
> Vladimir

