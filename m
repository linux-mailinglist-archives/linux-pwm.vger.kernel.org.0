Return-Path: <linux-pwm+bounces-3207-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 499FC975C3F
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Sep 2024 23:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A23A281D0C
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Sep 2024 21:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABA7154C04;
	Wed, 11 Sep 2024 21:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gFoA5vVm"
X-Original-To: linux-pwm@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011062.outbound.protection.outlook.com [52.101.65.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EE02AE69;
	Wed, 11 Sep 2024 21:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726089021; cv=fail; b=REw3ASn95z9eQHYD38qqiI+wGbeECzJNlma/tt3b3ugKc10cghrqLXAbvyom3r/GqH4/pjmr/24GGX1rFw72JQXDuNL934cnqH/8KVNyLSJGbQ/hfTKsW5722U3mVqfTnfDZD9WjFv7EXIwpuikavumhD8Zmk87zhKoHipI2e8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726089021; c=relaxed/simple;
	bh=h0IuQZ15CAl51xVN0RiBDm7GBaopzcwoDdJUzfeyLMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MhNs6NJrpQfCvdH7q4jzpTAayRJhsk80eoCzsOHJ0cWju9hC5GCd+gDI0Rn57Pt5/EOokNkCaOoHg1UippCbA3yHw0sPqm9yrCRAclAqUbibpXeWVMw4G2QE/Al2YQ5iTKHmvIxnInwWomSK9WStQ6ZdQhST6+cMNDWSVyeyFno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gFoA5vVm; arc=fail smtp.client-ip=52.101.65.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ECPRuLyDEEa1e7Eokj7Znyq/wgDMWt34i3I/dniQQ0XjjNwLyyRNXPXU13J5g020xW3yu8f580WvscBFRTkZrXGmswjUS4F8k1GkDlo9w8E/gsRnPgf87O6OJM13OQdF+CgFtMA5fLK1lfGRmdgtOuQGzuVzQCeVvWIXswgVBB1x1Fgk2Js/gXfqOAmVk1Y0wdGe4f7mHGZ/H35lYBOAyh0Fd0qhwVQr/DV46LsKnVBaDzQJuM2CJNjX9eXkSg+CQSS41ogKcFbrJPixNrXagnH+LNLcl/SObO0kjarw+ff7tce+qASUk00pF3nbX6vByIr3MNmOjKBeVc/U0u+yyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h0IuQZ15CAl51xVN0RiBDm7GBaopzcwoDdJUzfeyLMk=;
 b=SDSLQ1O89xmcbV8sxzJ+U+7mD/oYsIpgNy+b1oLYgS2QHxn+bEz2dyz8dSlwuHY8u4SNeF8F5slYumoWbgV+ADIkhTFW10oN6RCYcAVHLllbxsGQNvcm4TO8IeS3TxXivnPIwWOYA95SAArBNf+h38nUSEDz1mKS6MqIZaxXOGZAlvClDxJ2P8c8v+d/Q78pl/7lsennGaCm3ETKYj+GO1Sl/3BNI2QB09LVI48XL2L0z59X4RBn35ZzPAN8TcU1BKBUl5NpRWfw0QQhuv9GfyOJ6QCf+X18AiZiYcFHF2xYJhZ7akApqVyHqK02oWWeesYGwC2QDeMiWh6k6Ssv1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0IuQZ15CAl51xVN0RiBDm7GBaopzcwoDdJUzfeyLMk=;
 b=gFoA5vVms9JUolNElPVXa4jCAnxvPp/42csV2dQtU/b6n9kkqkoCYD+swUHAwZt28kt8EfgGOWoIxJJR7P54HmEoLmgCnhI9QPMPUxYX1trCsgdnw7HqR6aDdd51eQ93hv5244DdfFenhJVBr3qbLSihDd4WA7997LhdvFLtDKVxmhgbg48WAq++3x3feCTZ626YCp7XxU4QCykC/wsAwTY2+/Ro6H+A+1rQk4zt3lzAF0hnffpgM/049r8V9H9KDhz6HFZnGr4VvKKy46mF6imO6lgopiwPT/a2WM9lVu2H7RGgN6k2go/njzLxkCfPVT7eF4NsACi+qRDd6Z09ew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI2PR04MB10836.eurprd04.prod.outlook.com (2603:10a6:800:276::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.18; Wed, 11 Sep
 2024 21:10:16 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7939.022; Wed, 11 Sep 2024
 21:10:15 +0000
Date: Wed, 11 Sep 2024 17:10:05 -0400
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
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: pwm: imx: Add optional clock '32k'
Message-ID: <ZuIHLRhOjDOouWD7@lizhi-Precision-Tower-5810>
References: <20240910-pwm-v3-0-fbb047896618@nxp.com>
 <20240910-pwm-v3-1-fbb047896618@nxp.com>
 <2ede9457-8102-47e4-86dd-5888b6e5b8e6@denx.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ede9457-8102-47e4-86dd-5888b6e5b8e6@denx.de>
X-ClientProxiedBy: SJ0P220CA0030.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::6) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI2PR04MB10836:EE_
X-MS-Office365-Filtering-Correlation-Id: ccf43f3a-897e-4a31-cdbe-08dcd2a621d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rmG49yZ+L4wiovUBsTJJPRXYV0U1achEbR7eMCH8t4hj5wwkgyuk2wesWGtM?=
 =?us-ascii?Q?T15coGl48C7SG5a4UuVFRBKO12cidv9bu6PsdgyQKInE8aVyzFwvw87s2MRb?=
 =?us-ascii?Q?hty58FF4k7ipeeEY3pqHNoeCzsrRfHV1nP6jj0tWKmHKKKRDn3KmXK0Etc5r?=
 =?us-ascii?Q?AGcn5rGb249wcAnSrxwpiFsJivO8CIPrl3X/OOcTY3nH3zP1WFKAZ99r3vK5?=
 =?us-ascii?Q?l3x/o+wWxc7HDS4MOiFJb1BN0zPY9BLGCweokuxe7GutX0heThfZ2KZqjoid?=
 =?us-ascii?Q?Cn8jF5lF38PyF5P7liU+7OEDP8TUltELhwuNZx0wNFHEsP4nGU5LdRtCAqZ+?=
 =?us-ascii?Q?oIa9OB5Ejy+TVY8UdSy3fUkiZzyUgttrGHcC4E62hrNV62jeyKux/KvZNNsX?=
 =?us-ascii?Q?dmFk4XOWopnrD9Dpn+lOrCRqPo4o5k8jXZ9+Z4cytrOArlov82aDdRNqkTrC?=
 =?us-ascii?Q?UMEjQQEe9TZnZTp1fTOKmqjNX7AXx0eP+0sw/ewYfie7l39wx2jt8yrkv8Tm?=
 =?us-ascii?Q?bqul0Fq7k0waI0KKKDQBF8XcDNcnYGJxgqcoU8V3Lrqt1ZVAMsGVgOpEtoC0?=
 =?us-ascii?Q?9cfhZ1XXy4g/GgaNAkAFGd2jh4NCVsZ4vPpxx0UwWEQ7m+No/80pUgsKV4jW?=
 =?us-ascii?Q?dC0cG9SfTNoDfapTLkwoBBvkDQYcGjcDKYOW5CitLfAeFVcmFOEb1c5X9d2T?=
 =?us-ascii?Q?QiZxWZzS6M7o7Iy7GFQEdAgMmBQiEFxECangJVZ/4HjN5fZ7fqfAd/0AmHVq?=
 =?us-ascii?Q?9x9/8J75N9bDDuaOExT5Vn+FSOh0VfxXkf5E29VGPyTQrriBJQtI66PQfhqf?=
 =?us-ascii?Q?HYXpRv8lo4rsmWKGIFM+FambkPYFN1rFlk5FosCv/lEBE+QGpbXwsJkSV5BL?=
 =?us-ascii?Q?8Nf6LPGcHBd/ON+HB13emp4z5HXtJVKfivD6Kvoe8djF8Nu5twr24QWE8X+N?=
 =?us-ascii?Q?TmBd7hXSgpL1YpJAlh1VOZ+eld7sbTujIls+arZRRVIDPtG00jMz1WpGel1m?=
 =?us-ascii?Q?BSQ9WshvKtliy/jQMxZb/EiNLRW10buYSyiAzWcRuavBSeyfOawZX4Is0pjn?=
 =?us-ascii?Q?FvYEVnzEes6hLe4YNlXhgs9nTUyZ/2jIMWpIGVrsC0Wh4xEDNjMceH9cgeOC?=
 =?us-ascii?Q?vWKCqqO4wvQaDg5r9vLaXU+941ZcNnzqhE39R9xT9bLLwn9GETPY/9ekOVsS?=
 =?us-ascii?Q?IpAnDyBgh82KWCHIlXL3OoRmt1+ffjxdCalCP4nb6b78Z4m3gPYjFNBRexuq?=
 =?us-ascii?Q?XtQPpDiMkpQbf1n4OMHyGeUHjsWVxxGCedDbR64dhirN/GhxMOfaiiqyjhQq?=
 =?us-ascii?Q?3EbCBvGYLoiep9nkWfhAQJH+wYUPQHqO++XnCEa/FpT9/seK9KNujaeZaxxh?=
 =?us-ascii?Q?TCWZWGd/NzPZIIaPJE52UI4160ajXAT74uC/4cNqy+1PSwNxWw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I1Tr7oN/RO380xaYlF/VAxsQffNkIODiQ26LTzsUobByL6932KOZoi1kNlRy?=
 =?us-ascii?Q?xlMfTf3sjavA3FlDyfZZjuz1PZ7yCo+7uFfStGm6d9Nu7c8CxkNMNlhHUdef?=
 =?us-ascii?Q?7dg6C0KsEiO6hWMVWZx1AbglKEJiaR602bG00HY4ELg9G5c7dM83BoqtzS1s?=
 =?us-ascii?Q?/ZSFya4Vlbfjqi6NNpoylqZrYMyaDjI1EzYrSr8Ib7YH2ONVLkxiL/j4x9+H?=
 =?us-ascii?Q?typl3FOqfsHH474MU1K/G9ja6em3ojndOhrMY7MBMcMxxCx6k5WrHgQXMkc8?=
 =?us-ascii?Q?4wqHgZ9dw97l+jbFNk0vv6bnej49iUq/l3mQcgV3CDnS21ww2Rdz2uDPF415?=
 =?us-ascii?Q?vjLGHG/lxSES1IMuappBlLmMuTg7e8twREB/hw5MC1sal8Hjri6pW9gbefoZ?=
 =?us-ascii?Q?JwgI3WHTdJhpS9cuBhbe0WHQqvEWkBTDLVWMRJEek91ivLJw/bZzsnWnHb/e?=
 =?us-ascii?Q?FJOr880uCY6fJYWaCQkcbImoh5w5snQA866bdMEfL3AxqdXX6PbqWvfnmZp3?=
 =?us-ascii?Q?ZDZIf79jYZyoz1Pa0UoXhm8C4GgKjnI29NjtDSG5atd+Q+JfHugDsyBg/kQd?=
 =?us-ascii?Q?pxGUPZ8Z45j5KYROBTJYfZML186LlYkqbxZwteICxBnt82deVPkwv1PprZLp?=
 =?us-ascii?Q?nA3EUhWwPUxkGZTQPnBBYx9KPAzvQ/UGiI8gJzbCBMU0JxkjNyiAnsqyazwJ?=
 =?us-ascii?Q?DDAhTLGzbMu5amZNz79r0lJySH3v5+uvyHxEYA9wf6z8HkfTZyHN21CVLWtD?=
 =?us-ascii?Q?rt5ztFJWDc2Up04+5YamB9ZxT6ZrqIZrADWV313+nWxnlSA0/+cs3Y9V1SjO?=
 =?us-ascii?Q?UosOejbn4a8MbIa3XonRuCuZnpEtnDee7clEIWYRvf01A98lK3BHSUd9dqpi?=
 =?us-ascii?Q?+HG/SOby6DYqvKXO+08du2sJrLaG3c4dlLXGC6GL8ZOq900BsKc9UxN2KNzH?=
 =?us-ascii?Q?0smgnJe+jn8KWLZsj80sN67Dm0v1q1oMK2gB3O7715ElWInpISxXKmBm8kg4?=
 =?us-ascii?Q?i1PNvIeozaojiqoVZEiecnt0Mux+SA3TB7kUby2lSXwNNn6QP1rxu1R9muEO?=
 =?us-ascii?Q?SqsQ8f3I1aVKXVAL2sFoUZocxrloQxp8S82f5/2W0CDx+zn/86SpnsFam41N?=
 =?us-ascii?Q?fc3yaZk6nxvlHId7AUfDOoJTBYzjxyQ9Xpy4X/ffMjPVEMuJzNmtdNuS4AHw?=
 =?us-ascii?Q?w9YEuxeTqhvmD89Jjplwk3y+esdxJgZ69Q8qjrZMd8fISwwPd0zLJeZwEzPB?=
 =?us-ascii?Q?2kLy7ijI6+K11keHMFJ+YZWpmc6ekzEoyOyxSlbRpP/W1v3Z7gmoH5Wr+e5X?=
 =?us-ascii?Q?OlGxfrzisiBgWjvfNkiFkFk/AnXog6sd9LdauRo0DNst/dkmjO+o8Qxc+ZMV?=
 =?us-ascii?Q?O2J3FUXehZmnCOZ5MeMGocaGk/YG9B2Mf9HlHIIZuRxhoPW1zDU5MUya1Paw?=
 =?us-ascii?Q?ka89YZzpcq3s6u85zoeBgC5aua0kZYcgvqVTUoQ4JoVgQnRFH1IsuTl2au2q?=
 =?us-ascii?Q?5x76ZEoqZQBvaswERkWuEE3gEGiFBKaiMorZXSgNmIrXCHZ8KX7wmIHu9pW8?=
 =?us-ascii?Q?Hnk5Dn4bRaUPnn9+Rmg1UUAboWezpoKKOlogJ3bS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccf43f3a-897e-4a31-cdbe-08dcd2a621d2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 21:10:15.8107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q4YzTN7xpkiIQoBhYDIfOQcoyjF6lYHzlzt1gY5ybGY88i3e0rgHc2L3fi/lsXlIoeOwvGH7W1Kj8P8aTQz66Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10836

On Wed, Sep 11, 2024 at 10:28:52PM +0200, Marek Vasut wrote:
> On 9/10/24 9:07 PM, Frank Li wrote:
> > The pwm in imx8qxp mipi subsystem require one extra '32k' clock. So
> > increase maxItems for clock and clock-names.
>
> This mentions MIPI subsystem, but the IP in question here is PWM.

Here, mipi just name of subsystem, not related MIPI IP at all.

There are many IP in i.MX8QXP mipi subsystem, such as i2c, PWM, MIPI PHY,
MIPI controller, PLL, clock-gate, ...

>
> Are you sure the clock are assigned to the correct IP ?
>
> Shouldn't the clock be assigned to some MIPI IP instead ?
>

Are both question still validate if treat 'mipi' just name of subsystem.

> Could you please clarify this in the commit message ?

'mipi' just name of subsystem because the major ip is for MIPI. is word
'mipi-subsystem' better?


Frank

