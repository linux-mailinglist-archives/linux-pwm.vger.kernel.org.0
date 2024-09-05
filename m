Return-Path: <linux-pwm+bounces-3114-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8293C96E435
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Sep 2024 22:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 380D6286851
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Sep 2024 20:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05501A255F;
	Thu,  5 Sep 2024 20:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SKJnpz9s"
X-Original-To: linux-pwm@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2086.outbound.protection.outlook.com [40.107.21.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D45B17AE11;
	Thu,  5 Sep 2024 20:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725568691; cv=fail; b=AfiaMMf2MB9zMH8wOMwr8lx8lD7bYrdUJOYWcpvMONJjgvD7hOjR2XJyaY7UkA15hd9eZufg1h274VnEzpSsAiUMgcFngprFvN1OC7w280/ll3hU88LVv4xc2MfBn2W4oirIMSPkvHioOWv/3OR7h8Y1UOJvpygIAz6TTJF9YXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725568691; c=relaxed/simple;
	bh=4ZLRWnAJiXyCoaLyEe/QksJaboNv3njh7RFUdMQ/drc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kxoJwHlPYCQFvepw2CjtddNmGlkZYMXl3uJsQf6Z1o9ByZBuzhfe+6Ti4cyjYn15FotZqQ9/cDaaKizjRfyf40PGNeoMDcpro99OM6jvgkgvLIvSr2CRXVGpWNaK7a/NBHc0LrLJGWtWK5Q1By7JTdZteBijeg7zJCa3TkwNxbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SKJnpz9s; arc=fail smtp.client-ip=40.107.21.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sn7u00BjRmlZg6ZpXPd26PZV/q1Uy/EB40McFq+BIw1ZiYeCp3NrpB3RE+ES//IWAK8yrjxa+vS+v3YlepS4llCaMmxxKyqQIoOttRUmQwxK08hNmWprtmCAgbpi2xUBPf+fqemTQ9dpP/W5dIELnAyNaD3786j+9lM2A8tSziWnYZmXv8F2SmBE/qUmQpDu4F8q7aVY68erLsAu3cPy3IIcXUTbhPrCa3IQ58vz9mnLC9x+Uuzvdtr9+WHYwl9A0JRy8DudlA1JQbR1PQPv17EdKZetQ4jr4r3CspsgiY37cQBqw+vVaZCtQYeGL9q29jWTaC7NRJ0yaIgzxQzkGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mLV2udfqcSxDR9mOMM+zzZuPSwaniW2gN/NhmJ47RdE=;
 b=WizTLpVm1Be9kYXpMRpV/j2GmwOXjcqiglwd9EH9GY4K9ll7NqJXP/W2qMKMgDnwlTgsESQi63zTrRdWqpWdam1GfMuse3uA7CE9/ALquowTiry4C+oF8WtL3IPaXT3Khi0JgWeA4aWwGubJ/Vx1Uf1iQ8Mcn5Z/2e16r4wbzjSjkiQDp1U72rMmYVc9eVA7tCTDRT9oxBSzYlNrb/yngEIh92E2HBbHdhpUfEMON6z9qaiN9KzOcoJRf1D16FVPxVLUR+DDOjmY9KCzWMLvu9t19Cz9HeNdKGxBDvETLyFRlHdcnIVWUO8NG9AfEwI7ycnmuyzz+piK5AT6AacZDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mLV2udfqcSxDR9mOMM+zzZuPSwaniW2gN/NhmJ47RdE=;
 b=SKJnpz9sWd2vMZRpZQgAx0IPY8kShkhwb5EPBUAwyoNH+mXk4OiUM3G+FM+/pALDGVIsyKtQnNi9GZYagjR/qt+vLX7NXhcp9Pm27xP4czdHW8y34JbguEhD92PH/MVJF+aTyJcuhpTVMnE1WrAHLX27UuKTdr/d8JazQcOZzYsO9MPP+AXIdp400pEPy7fTzm6g17aO8tcoxRps5bgXy4NF6UHs9E7fGU7CW7tKcTyoh/qAjuCKyZi4ILa71McTzzDzqOXAaXJUqqzFewBa/DILGdZbKgEZyCBtN34vFWArZUWC/AtoqXLDrkovA7ReQ6x/Dexlk9O+Aw29Cjx81w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8152.eurprd04.prod.outlook.com (2603:10a6:20b:3fb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Thu, 5 Sep
 2024 20:38:05 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 20:38:05 +0000
Date: Thu, 5 Sep 2024 16:37:55 -0400
From: Frank Li <Frank.li@nxp.com>
To: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <festevam@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	pratikmanvar09@gmail.com, francesco@dolcini.it,
	Clark Wang <xiaoning.wang@nxp.com>, Jun Li <jun.li@nxp.com>
Subject: Re: [PATCH v2 3/3] pwm: imx27: workaround of the pwm output bug when
 decrease the duty cycle
Message-ID: <ZtoWowx1Vja3yjXc@lizhi-Precision-Tower-5810>
References: <20240715-pwm-v2-0-ff3eece83cbb@nxp.com>
 <20240715-pwm-v2-3-ff3eece83cbb@nxp.com>
 <CAOMZO5DNmHfHWbLoPj9P=_+JiLLQ4tiDd_90+UX+_psN2o+Knw@mail.gmail.com>
 <ac922fd5-9438-4f73-9a3d-08cceb1d7409@denx.de>
 <Ztn+SiBUp0BC5lzy@lizhi-Precision-Tower-5810>
 <1a5114c5-92d1-4f5a-9ad6-616475f3ba56@denx.de>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1a5114c5-92d1-4f5a-9ad6-616475f3ba56@denx.de>
X-ClientProxiedBy: BYAPR07CA0096.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::37) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8152:EE_
X-MS-Office365-Filtering-Correlation-Id: 98524f69-3d65-4c5e-9ac3-08dccdeaa49f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Slh1VVVuM2F1eVRLNnVldFhtV2MwN2NPOFkwb3pQNWgxbnZZYVpHZU9TdEVo?=
 =?utf-8?B?SFFHVXhqMEdiMmxlZ25YV3FIUmxKNlZCM0xIR09IOEtRdXFNbHNLNGh5NElO?=
 =?utf-8?B?UlVGMS8wUTR2TktVUFhBRTI3K2ZnT3J4aStQWDJPNUE0a0FHTFY0NzlmRktU?=
 =?utf-8?B?anVsV1hEMERkZ1B0WEVPY3VVY2lkdFR6YVRlY0l6YzVrTEZXUTZacTlQRXUz?=
 =?utf-8?B?ZXB1cXhpZjZsTUEyQkNpN3RSZnhQNlZQWkJGVmg1MHhhRUpjUkc4c0lsSlht?=
 =?utf-8?B?MkdFOURmcEFUdVNmSTZtakVoSDdZZ013WGlIRnlJY1ZRdUYyYmlxMFNRdFNP?=
 =?utf-8?B?Q0wxUDgyMkxyT3RUckc2Q0lPb2pqOUV6dzUvcXJBUmU1aXd3STRmTVFVVU9N?=
 =?utf-8?B?dFNqLzE2a1ByZWJvT0ZCYWdZaDZOcGh6NlNCU2VVVnM2WXZsY2pTQ1pFNDFC?=
 =?utf-8?B?TjNUVkhDQ0NleGNQSW9OdnVsNU1qeG9Md04yWVJ3SjJQUFR3VzhtaC9rSk1r?=
 =?utf-8?B?Y2ZFWGx0TFNPK2ZidXJGbXMvMnJ3M1ZiS3pZU3JVNkhvYWdxUkpjeFJobnR3?=
 =?utf-8?B?NkxKajJCcEgvRVVKL002MnRUYzVZdFhaZ096UlVEVmY1RXpoVlZlU3ovaGdj?=
 =?utf-8?B?NHREcE9VR0x0aGhTU09BaTNSaGJFRytxZWQwZC9ZeFlCMStvaUZXSFZ3Wnlt?=
 =?utf-8?B?b2tVbndrdW55cmJqQkQ2cFNGRDlwUUgrMTZLQ1ltOE1Oc21ESVFta1hpN1hX?=
 =?utf-8?B?aUxEUGQ2TmRzRGVXNzZDREg5L0dienk4RkJJY0FqTmRlYWU5cU02MHE2cm5Y?=
 =?utf-8?B?cStTWnZmdGJUbEZKWDFBSFkxN1NrWjVReDdNWDhZbGdxbENqQ21Vc3piSlJG?=
 =?utf-8?B?T1kyVCtLT2oxQ2JTRWNFdlNpZWZuZlVXMVlmd2QyRXAyb0lMb2Q0MjJ1b3hx?=
 =?utf-8?B?UkxCT3k1MHowVGZEWXRyQ01MaE1PZk93Wm1hSlAvMWJmSHNMYlBZVEgyS3p6?=
 =?utf-8?B?MEJ0OVVFRXh0S1lJM2ZJTEZkTzNUSDZvS2h3TExEWmxndmYzcWU1aXN2cmhI?=
 =?utf-8?B?NFhGcCtNR0xCb3ZITkdSQTZXZThRenlpd0xHUkhEdlBRUCtNM1p2OWl6bWhT?=
 =?utf-8?B?YVJmby9pMXZBUzNRQkFtOHJPY1FLY09ia1JSMkNZQnNhUjBRMjhmZ1FYRTlH?=
 =?utf-8?B?QmhyWWZPMVFybzhocEtLREErOXJVYkF3aVM5MEFUaURrOWVtSTVJY0JVYVVG?=
 =?utf-8?B?dkJub0VmUHJUMDZRQW1wanF2dzBub3FacHQ4eWFDb0cwRVkyL0RVbjdmOTRS?=
 =?utf-8?B?VjBjaE1XbklIMUhBN2c1Y1YxaXphRWNMVnF2eW9TaWpZQytISEtBTzNmMzBI?=
 =?utf-8?B?MXZKWWxlSzYvMHZYRlJxd1lLVlJzOGRjRTlZb1c2MDNsc3NiVC9sN1RQRjls?=
 =?utf-8?B?ZG1yNFBhSnErVXFoeE0yanVaY2IvN01QZzF0OGtnOW9icitlTGh4Y3c1Qkdy?=
 =?utf-8?B?Tk1HZ25jcU1lOVdyVjRjRjUybXhUVWVuMkYxc0lmK2VTZXdkVFU2YTZ5STB2?=
 =?utf-8?B?dGp6c3JGN2NhMC9JblpmQUxYSStWZDVsZkJOb1IrdHd4Z1VQT1owaGpId0Jr?=
 =?utf-8?B?M0tZLzUrYTFGMVZ4R0twakRKWHRXM3Jna0l6aWRYNk1TcU5tS2FOUjN1ZnBi?=
 =?utf-8?B?dDBDcmJtWHhhSFlGczRiZjVmcnpYWlFSdkpLdmI4bWNIeEtNQ3N1SEhJYnFj?=
 =?utf-8?B?NTFzaCtnNEswY0VmMVpzcFBvbGN6YUJQOUhiS1N3blJURy8rejRVZldZSHc3?=
 =?utf-8?B?V3ErSjVrbmV5ZE9aL0pZNzU0cjFveUhqWlZsME1QcU9CdnlGQmRIVzd0SWlQ?=
 =?utf-8?B?ZHVmSmhtdElTK0thRmFzUWlmZXNreVlrelB3NVd2dHUwWXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TVJxQWlsalREZnhDVndtUUtzUXFhcVJBN044UHlnZjdzcGJTZmIwNDVMVDJp?=
 =?utf-8?B?ajZxeHRMNTFPVjhzeEozbSt2d1M2dmFaVElLM2J3d2FrZUpuUnYxekRxTllv?=
 =?utf-8?B?QzlDVHZWNVRJMjVJaTgyclJ0aFEwUHpPZWJUYzNwSTZsVU1aQy9LaSthSXRl?=
 =?utf-8?B?MFBhQzQwWDdvYW1TWWdpcmlVNzREVWFmWEJxSEZyQjE4TFJIaFJlZXp2azBn?=
 =?utf-8?B?L25FY0J3eFgrcDJlc0lqeG9VME1FcEhIcTBYdVBSQ3BGWEZZdVpuc1N2RUtS?=
 =?utf-8?B?Uks3dGVnaHFJTUxaTkxFa2swUXA0SmFiNmYxYmFXdlRZa2dQdkQvSXZMenNB?=
 =?utf-8?B?ZUgyb3oxMmJ5STd6MEtJODlsaVFhZFVmZ01PcGN5eWROZkJJbkpXekM4SzFM?=
 =?utf-8?B?U2owbjM5UXNZNE5LamtGUDIvOHB0VUdQWmdEWjZsSXJsYWZFeEQ1aW5BMXAz?=
 =?utf-8?B?UkxMdWVuSG56Vlc2Q09pQmlEdHdRZzRvTThSYlIvRnM0UmJ3dWt0VVhNT2o5?=
 =?utf-8?B?aTkxQ2t6aWV5RW5jb2tkVEtKUE1zL1lhUFU0elB0ZmJjWGFSU0ljYlA2bzFW?=
 =?utf-8?B?RTJsdlluUHkrN2RmckNucCtPR2Q4WG1tSXlzMDFKQnUrdVNBQVFnTElXQk5X?=
 =?utf-8?B?M1FmRDhueit4L2ZOTWY4VFdWcElqeVpBNWVHamt3L2luZ09zdzdXSHQybzM0?=
 =?utf-8?B?clowTVpDNDRISjhVWWpZUy8wMkUwM0NvMkxSNXhUN3lUS1BlRm1wUm45dUhN?=
 =?utf-8?B?VmN4VUtMZEpXNnllb2cwVU5EZUU1b3BQeW42TDI3L1pIYmIxcGRtS2tubzQz?=
 =?utf-8?B?ZWlOTEhSRkZYa2ozb3NXQ3NZWjBFUVRqaXlPN3hmRjRnOUFXeDFGaWYxYno3?=
 =?utf-8?B?azBYUENwVzZlcHNLeGpOVFBOcjBsd3g1ZFpqeUF6UDk0bnk4Z0hhNjlEYmhy?=
 =?utf-8?B?elIwMkVFTTdPTm53NWlxT2E0dU0rRFh1cnhlWU5JS2F5aElVS3Z0Z0h3V0tv?=
 =?utf-8?B?cE8rYU1QZHFPSzZ4cjMxeVhXdkJUdzhYNDR0V0JzT2Jja01yd1ZhY0M4aThE?=
 =?utf-8?B?YTdMbndYRW95TUVJeGRnRVBjRk53UEZLKzErMmUyYVdPTXc5cGtqanY2dnBJ?=
 =?utf-8?B?akw5aFFxMVZOc2hKK05HdWRlYVpZVHU1ZUJNSzRrQk5HMi9nUE1ieE16Nnpu?=
 =?utf-8?B?a09OekVXTy9pZ3h6UDU4blhCa3MvREo4bFI0RkF6WE05OVNUY05oK3dlNWRp?=
 =?utf-8?B?Rzl1Nm0xWTF0aDBkWlg2S3lJWW9qQXVlTTJMZTNhaFdMeUxPaDlvQVhGQWdY?=
 =?utf-8?B?UkVwcGxYbmxXMVNJWWw5SHB3cW1zN0grbXhtczlCNDMyOXlIQ3ppK2JuYm5N?=
 =?utf-8?B?SW1RdUVJb09nM3dVcndsLzg1SFMzMm5RYlo4bHpVVVZHdDg2Z3BzSkE1c2Jl?=
 =?utf-8?B?SFJMT2tMb3V5VVNSRXFuN3ZwMVI2UTYzOUNqSWpIajV6K1VjTDdxUnQvdlRz?=
 =?utf-8?B?enZaWmdVRDlyc0JjY1IwaGVDSjZraENrZHcwbFdQRmtJWlgxdFk2Tkp4OGhJ?=
 =?utf-8?B?ZHNtZ04yS0NwVG1yOXZzcWVMa21QRExNM2pZVCtoWFpWY0xyNTZ0OW9NNEV1?=
 =?utf-8?B?TE0ybjh2c2JFTXh0VVpYUlpPSnUvOUE4TFcyTWtqTWg4eE81VFQybXhETjFx?=
 =?utf-8?B?MFh1a3liaUNwSDl3SUpreEN4Yi84amdrcXZaZ3JiWEx1eEhxWnlHUU9wZUZw?=
 =?utf-8?B?M0F5QWYzd21VWXV3STFuRTAyK3dxTlRsVCtBQnhHWG1hVGJsdC9PK3ZiVGVK?=
 =?utf-8?B?Y1hnd0F6dURzVTg5S2dBcHFQUXJnaEdRbTFvL3IvOGJDYy8vemdlalhxZzJw?=
 =?utf-8?B?R2MvNTJsOFJjM0U3ekgvUGJSQkdRZENZM0U2M2tNNVVyRmNMVXNhT0cvRE1n?=
 =?utf-8?B?S2UzL0Q0UWJ5aGVRYmtIcVZhZlF6ZkxzZUd5K1RTTzROM1VQdG10WEtRM24y?=
 =?utf-8?B?aXZhSzZnNUtDeXYvK0xDcXBzZEpMVVFVQTVGcnd4Lzl2TGJUWU5TY2VlTE41?=
 =?utf-8?B?YnFSZzU4V3RJcDRHeXg5UXVndDdLQ2xlSW5QKzJRNWwwSXN3SEp5Ly84Qkkz?=
 =?utf-8?Q?jV1WdGP1FHh19Ao4HqDCjmGIM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98524f69-3d65-4c5e-9ac3-08dccdeaa49f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 20:38:05.0302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZFU7y2J7coYR7NKMhy53KUUlEawlKUk6CaRNchEsPFvz9RhH8C0xMMIZVRsm3xmWa9bS5zEH0T8VV9BzM/jbSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8152

On Thu, Sep 05, 2024 at 09:01:06PM +0200, Marek Vasut wrote:
> On 9/5/24 8:54 PM, Frank Li wrote:
> > On Thu, Sep 05, 2024 at 08:26:34PM +0200, Marek Vasut wrote:
> > > On 9/5/24 7:12 PM, Fabio Estevam wrote:
> > > > Adding Marek.
> > > >
> > > > On Mon, Jul 15, 2024 at 5:30 PM Frank Li <Frank.Li@nxp.com> wrote:
> > > > >
> > > > > From: Clark Wang <xiaoning.wang@nxp.com>
> > > > >
> > > > > Implement workaround for ERR051198
> > > > > (https://www.nxp.com/docs/en/errata/IMX8MN_0N14Y.pdf)
> > > > >
> > > > > PWM output may not function correctly if the FIFO is empty when a new SAR
> > > > > value is programmed
> > > > >
> > > > > Description:
> > > > >     When the PWM FIFO is empty, a new value programmed to the PWM Sample
> > > > >     register (PWM_PWMSAR) will be directly applied even if the current timer
> > > > >     period has not expired. If the new SAMPLE value programmed in the
> > > > >     PWM_PWMSAR register is less than the previous value, and the PWM counter
> > > > >     register (PWM_PWMCNR) that contains the current COUNT value is greater
> > > > >     than the new programmed SAMPLE value, the current period will not flip
> > > > >     the level. This may result in an output pulse with a duty cycle of 100%.
> > > > >
> > > > > Workaround:
> > > > >     Program the current SAMPLE value in the PWM_PWMSAR register before
> > > > >     updating the new duty cycle to the SAMPLE value in the PWM_PWMSAR
> > > > >     register. This will ensure that the new SAMPLE value is modified during
> > > > >     a non-empty FIFO, and can be successfully updated after the period
> > > > >     expires.
> > >
> > > Frank, could you submit this patch separately ? The 1/3 and 2/3 are
> > > unrelated as far as I can tell ?
> > >
> > > > > ---
> > > > > Change from v1 to v2
> > > > > - address comments in https://lore.kernel.org/linux-pwm/20211221095053.uz4qbnhdqziftymw@pengutronix.de/
> > > > >     About disable/enable pwm instead of disable/enable irq:
> > > > >     Some pmw periphal may sensitive to period. Disable/enable pwm will
> > > > > increase period, althouhg it is okay for most case, such as LED backlight
> > > > > or FAN speed. But some device such servo may require strict period.
> > > > >
> > > > > - address comments in https://lore.kernel.org/linux-pwm/d72d1ae5-0378-4bac-8b77-0bb69f55accd@gmx.net/
> > > > >     Using official errata number
> > > > >     fix typo 'filp'
> > > > >     add {} for else
> > > > >
> > > > > I supposed fixed all previous issues, let me know if I missed one.
> > > > > ---
> > > > >    drivers/pwm/pwm-imx27.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++-
> > > > >    1 file changed, 51 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
> > > > > index 253afe94c4776..e12eaaebe3499 100644
> > > > > --- a/drivers/pwm/pwm-imx27.c
> > > > > +++ b/drivers/pwm/pwm-imx27.c
> > > > > @@ -27,6 +27,7 @@
> > > > >    #define MX3_PWMSR                      0x04    /* PWM Status Register */
> > > > >    #define MX3_PWMSAR                     0x0C    /* PWM Sample Register */
> > > > >    #define MX3_PWMPR                      0x10    /* PWM Period Register */
> > > > > +#define MX3_PWMCNR                     0x14    /* PWM Counter Register */
> > > > >
> > > > >    #define MX3_PWMCR_FWM                  GENMASK(27, 26)
> > > > >    #define MX3_PWMCR_STOPEN               BIT(25)
> > > > > @@ -232,8 +233,11 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> > > > >    {
> > > > >           unsigned long period_cycles, duty_cycles, prescale;
> > > > >           struct pwm_imx27_chip *imx = to_pwm_imx27_chip(chip);
> > > > > +       void __iomem *reg_sar = imx->mmio_base + MX3_PWMSAR;
> > > > >           unsigned long long c;
> > > > >           unsigned long long clkrate;
> > > > > +       unsigned long flags;
> > > > > +       int val;
> > > > >           int ret;
> > > > >           u32 cr;
> > > > >
> > > > > @@ -274,7 +278,53 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> > > > >                   pwm_imx27_sw_reset(chip);
> > > > >           }
> > > > >
> > > > > -       writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
> > > > > +       /*
> > > > > +        * This is a limited workaround. When the SAR FIFO is empty, the new
> > > > > +        * write value will be directly applied to SAR even the current period
> > > > > +        * is not over.
> > > > > +        *
> > > > > +        * If the new SAR value is less than the old one, and the counter is
> > > > > +        * greater than the new SAR value, the current period will not filp
> > > > > +        * the level. This will result in a pulse with a duty cycle of 100%.
> > > > > +        * So, writing the current value of the SAR to SAR here before updating
> > > > > +        * the new SAR value can avoid this issue.
> > > > > +        *
> > > > > +        * Add a spin lock and turn off the interrupt to ensure that the
> > > > > +        * real-time performance can be guaranteed as much as possible when
> > > > > +        * operating the following operations.
> > > > > +        *
> > > > > +        * 1. Add a threshold of 1.5us. If the time T between the read current
> > > > > +        * count value CNR and the end of the cycle is less than 1.5us, wait
> > > > > +        * for T to be longer than 1.5us before updating the SAR register.
> > > > > +        * This is to avoid the situation that when the first SAR is written,
> > > > > +        * the current cycle just ends and the SAR FIFO that just be written
> > > > > +        * is emptied again.
> > > > > +        *
> > > > > +        * 2. Use __raw_writel() to minimize the interval between two writes to
> > > > > +        * the SAR register to increase the fastest pwm frequency supported.
> > > > > +        *
> > > > > +        * When the PWM period is longer than 2us(or <500KHz), this workaround
> > > > > +        * can solve this problem.
> > > > > +        */
> > > > > +       val = FIELD_GET(MX3_PWMSR_FIFOAV, readl_relaxed(imx->mmio_base + MX3_PWMSR));
> > > > > +       if (duty_cycles < imx->duty_cycle && val < MX3_PWMSR_FIFOAV_2WORDS) {
> > > > > +               c = clkrate * 1500;
> > > > > +               do_div(c, NSEC_PER_SEC);
> > > > > +
> > > > > +               local_irq_save(flags);
> > > > > +               if (state->period >= 2000)
> > > > > +                       readl_poll_timeout_atomic(imx->mmio_base + MX3_PWMCNR, val,
> > > > > +                                                 period_cycles - val >= c, 0, 10);
> > > > > +
> > > > > +               val = FIELD_GET(MX3_PWMSR_FIFOAV, readl_relaxed(imx->mmio_base + MX3_PWMSR));
> > > > > +               if (!val)
> > > > > +                       writel_relaxed(imx->duty_cycle, reg_sar);
> > > > > +               writel_relaxed(duty_cycles, reg_sar);
> > > > > +               local_irq_restore(flags);
> > > > > +       } else {
> > > > > +               writel_relaxed(duty_cycles, reg_sar);
> > > > > +       }
> > >
> > > Why so complicated ? Can't this be simplified to this ?
> > >
> > > const u32 sar[3] = { old_sar, old_sar, new_sar };
> > >
> > > val = FIELD_GET(MX3_PWMSR_FIFOAV, readl_relaxed(imx->mmio_base +
> > > MX3_PWMSR));
> > >
> > > switch (val) {
> > > case MX3_PWMSR_FIFOAV_EMPTY:
> > > case MX3_PWMSR_FIFOAV_1WORD:
> > >    writesl(duty_cycles, sar, 3);
> > >    break;
> > > case MX3_PWMSR_FIFOAV_2WORDS:
> > >    writesl(duty_cycles, sar + 1, 2);
> > >    break;
> > > default: // 3 words in FIFO
> > >    writel(new_sar, duty_cycles);
> > > }
> > >
> > > The MX3_PWMSR_FIFOAV_EMPTY/MX3_PWMSR_FIFOAV_1WORD case will effectively
> > > trigger three consecutive 'str' instructions:
> > >
> > > 1: str PWMSAR, old_sar
> > > 2: str PWMSAR, old_sar
> > > 3: str PWMSAR, new_sar
> > >
> > > If the PWM cycle ends before 1:, then PWM will reload old value, then pick
> > > old value from 1:, 2: and then new value from 3: -- the FIFO will never be
> > > empty.
> > >
> > > If the PWM cycle ends after 1:, then PWM will pick up old value from 1:
> > > which is now in FIFO, 2: and then new value from 3: -- the FIFO will never
> > > be empty.
> > >
> > > The MX3_PWMSR_FIFOAV_2WORDS and default: case is there to prevent FIFO
> > > overflow which may lock up the PWM. In case of MX3_PWMSR_FIFOAV_2WORDS there
> > > are two words in the FIFO, write two more, old SAR value and new SAR value.
> > > In case of default, there must be at least one free slot in the PWM FIFO
> > > because pwm_imx27_wait_fifo_slot() which polled the FIFO for free slot
> > > above, so there is no danger of FIFO being empty or FIFO overflow.
> > >
> > > Maybe this can still be isolated to "if (duty_cycles < imx->duty_cycle)" .
> > >
> > > What do you think ?
> >
> > Reasonable. Let me test it.
> Thank you.
>
> I have MX8MN locally, so if you need RB/TB for V3, let me know.
>
> Will I be able to reproduce it on another iMX too? Like MX8MP or MX8MM (they
> are a bit easier to work with for me) ?
>
> Could you include "how to reproduce" in the commit message ? Something easy
> like:
> - Write this and that sysfs attribute file with old value
> - Write this and that sysfs attribute file with new value
> - Observe this on a scope

I will add it at next version. But I found a problem of your method,
especially when period is quite long, for example 2s. Assume  FIFO is empty.
[old, old, new] will be written to FIFO, new value will takes 2s-6s to make
new value effect.

The currect method, most time, the new value will effect at next period.

Frank


