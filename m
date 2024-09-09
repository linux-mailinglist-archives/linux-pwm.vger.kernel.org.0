Return-Path: <linux-pwm+bounces-3173-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C75809722EF
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Sep 2024 21:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8101E281B63
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Sep 2024 19:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF04B188CC8;
	Mon,  9 Sep 2024 19:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZhV0vgjR"
X-Original-To: linux-pwm@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2073.outbound.protection.outlook.com [40.107.22.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468F53CF51;
	Mon,  9 Sep 2024 19:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725910913; cv=fail; b=m/cIv995M81M7mlTkUZndcFp2eWfH59EohOuiLeaS4I6ZXtJd/Cn+DJhs+tLvFzJ2RQ6/Cq6ep1WV3rHUV4uTb8dElG9qyAPh7eJwsotwQ3EDeXzBdKLeatZG+AkeM2UEFGZBzETIA8n14RnOIlSe+xaOMLwQqFfHIpguKxw30I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725910913; c=relaxed/simple;
	bh=FXL8qBOutVPkVoPEmA/QPyAyRxQAhXyj9rmoB1BNcpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SItT51BQfm+mMetk1uQIQowHwbjTCnXwg8lQN565Zworj4ymf+rNsVkerxuS4vMQYCnZnqB6EZQdTcWdgXniEae2acjDs02d1F0UKJhfZXGgJ6yqvLERRATi4CUBIBtxpx6fG3RVXYtRdjw9zMXhNxQYMvLioNbZ4IOau2v9cas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZhV0vgjR; arc=fail smtp.client-ip=40.107.22.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lYX1kRIfMGFWk1p5dX94XdEs+gxYO8WyeX6v8GCZ4GR4VbUVTfL4LeHiVXl0A7EH1bGGEShdEHEqClBoK0niNsCZ6M+mKcRh6zigb5Hbajx363RlDlC1tVm8bs4CsPNnWg8qfwB4/3WzXJXU40YAaMv2GFuD4yV89B0OYL200n81mncBgWkSXRKY9E18Hb48JqX+zs7p/LXAJMhPGPM0SItNcPjeCbz8QarFnhdsPrsV/pVRKtFCkhsiSIOfOYH1vB/KeO4zAhQ8dAfKv4tPL5z+MITMAN8I7+k9UjFDWjnkla9DmKx54yKVgMC5NAs2qz5O+CVcmUgAIPfohNRYCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xVk/rVPkNgfoeZEaziQJxaIO5kwFPfS7iNG3Sml5Kto=;
 b=i4tC9bzxQiGI+P8oM+aIwH5VIDplXkpIVAsOr90cSAzkJ3DpzNXEAjR/6pevR8RscFXNSHFI0lvG4n8ZEdNx6dHq8tXkID7etr1m1a/BAjpwB4fQW/wFl7HkJ0EmdsoFivYUBNlsmRynZ9CzzwOS2Fv+Qsn57i9dG5ChxcZ0Lv0Peb0Dh7oNXokoOH+sAauVqpmPDTyVQx8FGcPe56I1x6f8z2/mlu+TNyyaKkJ09q7f3deRsK/Noww1yBkbICaT1UiKLT7hk7zm4CTmG5gtZkzpvcRt/i3zmmYD22oEMQY5Ayl32KqCZQysrFRHqjkAtrgJygIBFwVY2vjkVT/O0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xVk/rVPkNgfoeZEaziQJxaIO5kwFPfS7iNG3Sml5Kto=;
 b=ZhV0vgjRpt0XTT8G3XhktYBlnbuSXQgQrui/Nn7c/Fi1qGVoSsmghwbakuggSVIZNaezPCHV6WrnoEAR7WugZsFEOB79h2+W6UbKYsWpCeoH/0Hxoewp15w1wJdokyf88GR4At2AKHKtcalkg8or9u74bNVfxqtUwhS5mMkppwEVT+0x1wDhUBXpbg7/9XV1b9zQ49LQe4k4j8k79xsx1UXTY0MkQZg53s5KkPLEZ13jh30TPZcGmyxnHqk9CR2UtLqPwxvhLqxxnHqESlbAxvv/uIXONffdKZ/mphSctnKtfukSocOQzE3b2QxD8I54qNjVatUBhvRmu0/9l41wTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB7716.eurprd04.prod.outlook.com (2603:10a6:20b:280::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Mon, 9 Sep
 2024 19:41:48 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7939.022; Mon, 9 Sep 2024
 19:41:48 +0000
Date: Mon, 9 Sep 2024 15:41:38 -0400
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
Message-ID: <Zt9PcsUg4CdMbpov@lizhi-Precision-Tower-5810>
References: <20240715-pwm-v2-0-ff3eece83cbb@nxp.com>
 <20240715-pwm-v2-3-ff3eece83cbb@nxp.com>
 <CAOMZO5DNmHfHWbLoPj9P=_+JiLLQ4tiDd_90+UX+_psN2o+Knw@mail.gmail.com>
 <ac922fd5-9438-4f73-9a3d-08cceb1d7409@denx.de>
 <Ztn+SiBUp0BC5lzy@lizhi-Precision-Tower-5810>
 <1a5114c5-92d1-4f5a-9ad6-616475f3ba56@denx.de>
 <ZtoWowx1Vja3yjXc@lizhi-Precision-Tower-5810>
 <e14fba9a-87e9-42a3-9be8-b2b48ed08cd0@denx.de>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e14fba9a-87e9-42a3-9be8-b2b48ed08cd0@denx.de>
X-ClientProxiedBy: SJ0PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::12) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB7716:EE_
X-MS-Office365-Filtering-Correlation-Id: ca940c11-5ff4-4882-037a-08dcd1077167
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ekRMQ1V5Q2xlSnZQVEwwTy94bkJpazhnazJXTEcwWlFEWG9DTkt1NGxTQjZV?=
 =?utf-8?B?dEt6ZXZuMWczOWptcU5HTUtzMEZyK0s2Q1piZUJqcHJvU3prNmpEMnZ1Q0lr?=
 =?utf-8?B?YmIvTk5lc1hUMHJTWDJKMWRwalZYTlUzWHpBSnBOK2txQU9vZC9HSHBBZ3JD?=
 =?utf-8?B?NVlleExhSi90U3NtelBmVVNRU01QTEJkQ2pvUnJUUncwRXZYRDdVTWxmMGVD?=
 =?utf-8?B?K0VaTEM5Rk4wakt2dlR6VUl1OVRLOFJqaEVGYkYveEdURDFaOTY3eG1hUE1u?=
 =?utf-8?B?ZlN3Q1E5VmZsNUdXQ1JvOXFUQkNNN0VSbWJoVlFHa3k3WDlqaXVla3B2eW5v?=
 =?utf-8?B?ZDF4R2lMckg2U1hqb2FyOGxzYlYvQzZyaVdqcnFCeEtpdWMvc25sRVlodVRJ?=
 =?utf-8?B?RHBLR01HNGpFVzMxak5EZEJndGdjVGQyNGwrMTl2TC9zNVdjUFlIb1d2YmpL?=
 =?utf-8?B?VHYvcTN3b0JSQjByUFZrMW01d2s1cGJhMEU3SXlUanZ6N3hJV0ltSHZFa2Nr?=
 =?utf-8?B?eHZLM1NMU25sVStkMmh6Z24wUUpoc1FuSHlrelptMC9ZaTYvMnZGTmRJcUJ4?=
 =?utf-8?B?dGdjZzZ5Sk4vQ0F5Mm1jY3cwNDJwd2VUbnYyUjRGdDF6Wk12QXVzZ2dhSkJv?=
 =?utf-8?B?OTluc2RnMlFuRUF3eUNrWDI1aVdtU3dWOGdGMVZRdFEvVmtXL1J3cjl0QlYx?=
 =?utf-8?B?K3EwVzJBOFdHYXVKTHRYa1F5d3VQMktobFJzZFgzU2FXK3NmeE5jbU5nTzFW?=
 =?utf-8?B?emtMSXhiUXJ2bm9iN3dZeGh5aW4rSmE2dTMwUTdNMkRLNHNSYVFBVlNOYjRp?=
 =?utf-8?B?V2dUelBjRk1BOVMwNFZ4Y0kwUHVNODZVWDlRN0RKZ0loTXJNeUZjb01TN0Jv?=
 =?utf-8?B?a0dCd2QxOVlkOVlkQlliUVdBYU9zeXRrN2FRWDlDUlY1L3gyUmp3RjFtbXNN?=
 =?utf-8?B?ZytUTXFDclpJQ2VmZTNxUlFmN0xudlQvMytTU1BSMFI0ZTNKaWEzTzF4dmFG?=
 =?utf-8?B?WnZJSkptaGFqUTVBL3dmTzVNdm5hd2lZV28vUVI2blpvdEY2S2FlQ0dISUd3?=
 =?utf-8?B?SDBpZ1ErNDArY2FXckx1WG1IT0tONWZyN2N4ckljRmdUSVZrODl5Qm45NUpw?=
 =?utf-8?B?anRDbklYbnZSbGJKRzQ1LzM2dzhKcmJITXNMK2lid3kySjNsZ3dKYm81UXhX?=
 =?utf-8?B?dE80VjhwL0g3SWVHblhsWk41SlpaODI1UGFyUnpOWlBPQUo2RTVZMlJ6V1FU?=
 =?utf-8?B?TUlmUW05cFppdWhvZGpkRmhUaUFXa1VtNnkyUkxlUVlaaVg0YjhaQ0dkQy8z?=
 =?utf-8?B?dEtkTUQ4ZlRWOURpbEVLSHdibnhSZHh4Z29FbWE2VU1zNGlGTkprc2U1ZVZV?=
 =?utf-8?B?VW1kamJjZUJXalVWZEdrWFJQdWxydUtRU0hvN09WSy9ZUkthaVM3MVZPbTRB?=
 =?utf-8?B?RjBHamJwNGRzRHI0Ris2R09UYkM1Mm1jQVJOYXRVSlIwZmk1c3pnUWxzbjMx?=
 =?utf-8?B?U2MxY2FzZUhXaGRSVGpDOVJNb1l0MkgzbjZtbStueW41WnlHYWFxRGhSdWtE?=
 =?utf-8?B?UUFrcE9JNUUrbUJMYVBEQXpyaEJnUFFySU5mbEdBZnhKZlNob0szbzNpSDU5?=
 =?utf-8?B?RmZuWlVoK0JwTnBvMUFMNFhSa1cxa3h6NWlxdURFU1lISjFnazFSNFk2Umd1?=
 =?utf-8?B?bHZTZ3lxaW02T1Q4Rkw3YVEyelB4Y0VudXpIVVdvWFZYYlh6L3hTbU1JVzdj?=
 =?utf-8?B?WlhZUnREVW1zbTJqZkIwam9mSkxVR2srQ3V4WHIwMDI5WnN5OWp3MG5RM3I4?=
 =?utf-8?B?WTZvQ1BvSlJscks5R3JQempENVNnMEtOZ1FVdkFNNmRmY25kd1NsblFWWXVx?=
 =?utf-8?B?N0RGbGlham03bjU1OUNIMFpLV3c0QXV1Y3EyZ0F4OUZOUGc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YW5uZkZBNGdrTSs3RlZxb1duTGl4bzRaU1VYR2xTZXVEVWdGYmhoTjBQSTNR?=
 =?utf-8?B?RWpZWkw5eDIyN2k3NVhGdHdwNFpRcGFxc3pabURZRWFhNmg5NHMrejZjei85?=
 =?utf-8?B?ZUhCREtBN3FBUmRMeTIwUHVLcksvaUhjWWF6RytxQ1U3cHMvZEtzRDRwY0Yz?=
 =?utf-8?B?NnZXQ05oU2M0SitxYTQyNU5CKzZKQkp2SGNsVXJBUFBObGJSOUI3QysyZmZM?=
 =?utf-8?B?K1YzS2dsbVdveWNCZjV3YlZvZWZRbWpWUXJqMlpTRGxuR05HQi9LRjRXcyt3?=
 =?utf-8?B?Uyt1Nk4yVzFCV0NkQXFzR1BJVHAySmpiS2FLbDhpM1A4T0ZsYlBkRVV2Rkps?=
 =?utf-8?B?b2cwS0lNWEg1R1o0NDJ4RUJJVFlpR1ZDaHNTdDZtNWZrUnMxOHppcXJuejEr?=
 =?utf-8?B?S1A3by9xdkd0K0FUUXpLN0lRRm9DMXJCZk1uaVY5Vk1UemxBTVFIOFRyQ3pr?=
 =?utf-8?B?Ky84aU1ydHBUMEg3K3FGY05tMWlJMWJsS3pFVW4zMmE5a1E0QTJVUkFYdk8x?=
 =?utf-8?B?NWNtdVgxeHhieW5YTGl5ajM2eFJTa3k2bmowY3VzaVAzOENvbk5JTUx5czU5?=
 =?utf-8?B?blQ1aEhGSmtkb3JZNXg4QXNXNGlXQXNDVStPSWUxcVJxcklENVgreXVTVWM1?=
 =?utf-8?B?WjkxQ1BXUkMxRmdScWtkVy9rVVpJemZ6UHRXay8xc0k0cTFTMTZqRVN5WFFV?=
 =?utf-8?B?NGZ1VmVZaERxMFNhWGJzK1d6c1ovU3U1VEU2WjArL2QvSUtrMS91L3pKOWln?=
 =?utf-8?B?N3V6T01iY2Z5YWlnVHZ6SXYxZ0VhTGt3YWVkS3pFMmlrT2x3QzJVWjdQc3pH?=
 =?utf-8?B?QXdpQVd5UHVoSHM4TUZuMXNCeDFUY01lV2xSdmJRejN0WmdUaWd6NzZXV1FP?=
 =?utf-8?B?YmhSQjNZZGx6d29MMTJaOTRSR0VxdWMzc3FRUzN1Ymd0NWJMd213eEVTQ2hI?=
 =?utf-8?B?dHVPNkMvTkhXNzlJbE8wVlJFUERxNjE4ZUhaTTVjYTRMeVE5M2xsbVdzdXUz?=
 =?utf-8?B?aDR5OE9RZmkvcVhMQWY4bThYSzRUK04vNzRNSG1JMU1uYmRXbnZnTzJtTzRz?=
 =?utf-8?B?Y0o1bkxtWnRySFhITHBXdmxFRE5CSWlHN1BnaUF5K3hpRmd5U29DcWhPMk96?=
 =?utf-8?B?Y3VmK0s1V0Z2Ky9lMi9VemM2VXpSR2lVY3R0QUdzTlVYTElyeHM1QnphbDlj?=
 =?utf-8?B?TUJKZ1FHV2JIRlNIZlB4ZEFTckdTOHBJSU5oMWpKUGx5N3NPcVJLbkp1cmJ3?=
 =?utf-8?B?cklKMTd1bzc1OFpXMFl0SFQ1bnJXWTBydmpuK0cxZnRJRUxYZzhoZ0NXWDVv?=
 =?utf-8?B?Z3JNY0R4c0ZZZGtNUGZMcDVBUFgzdmxvMVJzalFJQng1eGs1MTdTRnc2TjJK?=
 =?utf-8?B?MldWczdmZ1g1ZXhDSlErNFJBT2owOW9IVC9HMmZrb2wzcUVnZkNJSk1vd0to?=
 =?utf-8?B?RUs5WVl6Y1ZRa2pBUlFneFNvYXZQS2lWWnpYN0cyMWVwTVdEY0FiVzgyMTMy?=
 =?utf-8?B?dVJUengxUmc0MXZSbERZbFVTSWhJbkVZb1JIZ3NYLzVOQkFpSGI2cUFBWHBo?=
 =?utf-8?B?ek1KbjZSOUo5RmRuOEM5bDNQUktFdFRZT2RDSXE2TlFRRHQ2UW9qeFF4cmh5?=
 =?utf-8?B?ZmlBQnUxNm9LZGx2QzFBZHFEa0tuazFkUGRlMjhPZlNRb1pZQ2xVaFlHMzRO?=
 =?utf-8?B?NEsvbnQvNVJZWWlSTWNhN3orc0dMZmNPSzQwZ3dnNlBIcmVsUmEvaUhTem05?=
 =?utf-8?B?VkVLWDJsYnhRa0dLZ1NmMkQ2b0dYSkJBa0ZhSERUNXNXVEdlMFlBSkZnSUhE?=
 =?utf-8?B?UUIyS2lEWjFOZkxvcytJNjRBRUtNeWJGQjhiNWQxNDBmQ1gyYkJMam5tSFE3?=
 =?utf-8?B?Vmh2c0x2cWxMR2hEZGc1bG9rMnA3aHJlNVpmTHBLd3NEdjJNaWcrbGo0UkJh?=
 =?utf-8?B?OVBwSFZvTWV4RHZWUnFTbEZnL0FHZUlUQi9EY015VklYSFpRV1NCY2Vmclg2?=
 =?utf-8?B?TCtzUU1UZG9NV215VktNRU9aaGxSeGNodzhKNFJXejFTT1BwNS9XZkY4WUJU?=
 =?utf-8?B?UVN3a0creVZ3VWJIcnpUampYNzViY0J3VHZHanc0S3R2a0JjNGFlQ1oxT0dW?=
 =?utf-8?Q?Op5I=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca940c11-5ff4-4882-037a-08dcd1077167
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 19:41:47.9076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V4cr0LvkUpXgPFYf5cIuXyv+vOZdJdwk0u9PoyMXvQERPgzP5Ee3GVJik/D0ztTU+Ukz7HJZGX/9/f29ouzZLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7716

On Fri, Sep 06, 2024 at 06:33:45AM +0200, Marek Vasut wrote:
> On 9/5/24 10:37 PM, Frank Li wrote:
> > On Thu, Sep 05, 2024 at 09:01:06PM +0200, Marek Vasut wrote:
> > > On 9/5/24 8:54 PM, Frank Li wrote:
> > > > On Thu, Sep 05, 2024 at 08:26:34PM +0200, Marek Vasut wrote:
> > > > > On 9/5/24 7:12 PM, Fabio Estevam wrote:
> > > > > > Adding Marek.
> > > > > >
> > > > > > On Mon, Jul 15, 2024 at 5:30 PM Frank Li <Frank.Li@nxp.com> wrote:
> > > > > > >
> > > > > > > From: Clark Wang <xiaoning.wang@nxp.com>
> > > > > > >
> > > > > > > Implement workaround for ERR051198
> > > > > > > (https://www.nxp.com/docs/en/errata/IMX8MN_0N14Y.pdf)
> > > > > > >
> > > > > > > PWM output may not function correctly if the FIFO is empty when a new SAR
> > > > > > > value is programmed
> > > > > > >
> > > > > > > Description:
> > > > > > >      When the PWM FIFO is empty, a new value programmed to the PWM Sample
> > > > > > >      register (PWM_PWMSAR) will be directly applied even if the current timer
> > > > > > >      period has not expired. If the new SAMPLE value programmed in the
> > > > > > >      PWM_PWMSAR register is less than the previous value, and the PWM counter
> > > > > > >      register (PWM_PWMCNR) that contains the current COUNT value is greater
> > > > > > >      than the new programmed SAMPLE value, the current period will not flip
> > > > > > >      the level. This may result in an output pulse with a duty cycle of 100%.
> > > > > > >
> > > > > > > Workaround:
> > > > > > >      Program the current SAMPLE value in the PWM_PWMSAR register before
> > > > > > >      updating the new duty cycle to the SAMPLE value in the PWM_PWMSAR
> > > > > > >      register. This will ensure that the new SAMPLE value is modified during
> > > > > > >      a non-empty FIFO, and can be successfully updated after the period
> > > > > > >      expires.
> > > > >
> > > > > Frank, could you submit this patch separately ? The 1/3 and 2/3 are
> > > > > unrelated as far as I can tell ?
> > > > >
> > > > > > > ---
> > > > > > > Change from v1 to v2
> > > > > > > - address comments in https://lore.kernel.org/linux-pwm/20211221095053.uz4qbnhdqziftymw@pengutronix.de/
> > > > > > >      About disable/enable pwm instead of disable/enable irq:
> > > > > > >      Some pmw periphal may sensitive to period. Disable/enable pwm will
> > > > > > > increase period, althouhg it is okay for most case, such as LED backlight
> > > > > > > or FAN speed. But some device such servo may require strict period.
> > > > > > >
> > > > > > > - address comments in https://lore.kernel.org/linux-pwm/d72d1ae5-0378-4bac-8b77-0bb69f55accd@gmx.net/
> > > > > > >      Using official errata number
> > > > > > >      fix typo 'filp'
> > > > > > >      add {} for else
> > > > > > >
> > > > > > > I supposed fixed all previous issues, let me know if I missed one.
> > > > > > > ---
> > > > > > >     drivers/pwm/pwm-imx27.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++-
> > > > > > >     1 file changed, 51 insertions(+), 1 deletion(-)
> > > > > > >
> > > > > > > diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
> > > > > > > index 253afe94c4776..e12eaaebe3499 100644
> > > > > > > --- a/drivers/pwm/pwm-imx27.c
> > > > > > > +++ b/drivers/pwm/pwm-imx27.c
> > > > > > > @@ -27,6 +27,7 @@
> > > > > > >     #define MX3_PWMSR                      0x04    /* PWM Status Register */
> > > > > > >     #define MX3_PWMSAR                     0x0C    /* PWM Sample Register */
> > > > > > >     #define MX3_PWMPR                      0x10    /* PWM Period Register */
> > > > > > > +#define MX3_PWMCNR                     0x14    /* PWM Counter Register */
> > > > > > >
> > > > > > >     #define MX3_PWMCR_FWM                  GENMASK(27, 26)
> > > > > > >     #define MX3_PWMCR_STOPEN               BIT(25)
> > > > > > > @@ -232,8 +233,11 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> > > > > > >     {
> > > > > > >            unsigned long period_cycles, duty_cycles, prescale;
> > > > > > >            struct pwm_imx27_chip *imx = to_pwm_imx27_chip(chip);
> > > > > > > +       void __iomem *reg_sar = imx->mmio_base + MX3_PWMSAR;
> > > > > > >            unsigned long long c;
> > > > > > >            unsigned long long clkrate;
> > > > > > > +       unsigned long flags;
> > > > > > > +       int val;
> > > > > > >            int ret;
> > > > > > >            u32 cr;
> > > > > > >
> > > > > > > @@ -274,7 +278,53 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> > > > > > >                    pwm_imx27_sw_reset(chip);
> > > > > > >            }
> > > > > > >
> > > > > > > -       writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
> > > > > > > +       /*
> > > > > > > +        * This is a limited workaround. When the SAR FIFO is empty, the new
> > > > > > > +        * write value will be directly applied to SAR even the current period
> > > > > > > +        * is not over.
> > > > > > > +        *
> > > > > > > +        * If the new SAR value is less than the old one, and the counter is
> > > > > > > +        * greater than the new SAR value, the current period will not filp
> > > > > > > +        * the level. This will result in a pulse with a duty cycle of 100%.
> > > > > > > +        * So, writing the current value of the SAR to SAR here before updating
> > > > > > > +        * the new SAR value can avoid this issue.
> > > > > > > +        *
> > > > > > > +        * Add a spin lock and turn off the interrupt to ensure that the
> > > > > > > +        * real-time performance can be guaranteed as much as possible when
> > > > > > > +        * operating the following operations.
> > > > > > > +        *
> > > > > > > +        * 1. Add a threshold of 1.5us. If the time T between the read current
> > > > > > > +        * count value CNR and the end of the cycle is less than 1.5us, wait
> > > > > > > +        * for T to be longer than 1.5us before updating the SAR register.
> > > > > > > +        * This is to avoid the situation that when the first SAR is written,
> > > > > > > +        * the current cycle just ends and the SAR FIFO that just be written
> > > > > > > +        * is emptied again.
> > > > > > > +        *
> > > > > > > +        * 2. Use __raw_writel() to minimize the interval between two writes to
> > > > > > > +        * the SAR register to increase the fastest pwm frequency supported.
> > > > > > > +        *
> > > > > > > +        * When the PWM period is longer than 2us(or <500KHz), this workaround
> > > > > > > +        * can solve this problem.
> > > > > > > +        */
> > > > > > > +       val = FIELD_GET(MX3_PWMSR_FIFOAV, readl_relaxed(imx->mmio_base + MX3_PWMSR));
> > > > > > > +       if (duty_cycles < imx->duty_cycle && val < MX3_PWMSR_FIFOAV_2WORDS) {
> > > > > > > +               c = clkrate * 1500;
> > > > > > > +               do_div(c, NSEC_PER_SEC);
> > > > > > > +
> > > > > > > +               local_irq_save(flags);
> > > > > > > +               if (state->period >= 2000)
> > > > > > > +                       readl_poll_timeout_atomic(imx->mmio_base + MX3_PWMCNR, val,
> > > > > > > +                                                 period_cycles - val >= c, 0, 10);
> > > > > > > +
> > > > > > > +               val = FIELD_GET(MX3_PWMSR_FIFOAV, readl_relaxed(imx->mmio_base + MX3_PWMSR));
> > > > > > > +               if (!val)
> > > > > > > +                       writel_relaxed(imx->duty_cycle, reg_sar);
> > > > > > > +               writel_relaxed(duty_cycles, reg_sar);
> > > > > > > +               local_irq_restore(flags);
> > > > > > > +       } else {
> > > > > > > +               writel_relaxed(duty_cycles, reg_sar);
> > > > > > > +       }
> > > > >
> > > > > Why so complicated ? Can't this be simplified to this ?
> > > > >
> > > > > const u32 sar[3] = { old_sar, old_sar, new_sar };
> > > > >
> > > > > val = FIELD_GET(MX3_PWMSR_FIFOAV, readl_relaxed(imx->mmio_base +
> > > > > MX3_PWMSR));
> > > > >
> > > > > switch (val) {
> > > > > case MX3_PWMSR_FIFOAV_EMPTY:
> > > > > case MX3_PWMSR_FIFOAV_1WORD:
> > > > >     writesl(duty_cycles, sar, 3);
> > > > >     break;
> > > > > case MX3_PWMSR_FIFOAV_2WORDS:
> > > > >     writesl(duty_cycles, sar + 1, 2);
> > > > >     break;
> > > > > default: // 3 words in FIFO
> > > > >     writel(new_sar, duty_cycles);
> > > > > }
> > > > >
> > > > > The MX3_PWMSR_FIFOAV_EMPTY/MX3_PWMSR_FIFOAV_1WORD case will effectively
> > > > > trigger three consecutive 'str' instructions:
> > > > >
> > > > > 1: str PWMSAR, old_sar
> > > > > 2: str PWMSAR, old_sar
> > > > > 3: str PWMSAR, new_sar
> > > > >
> > > > > If the PWM cycle ends before 1:, then PWM will reload old value, then pick
> > > > > old value from 1:, 2: and then new value from 3: -- the FIFO will never be
> > > > > empty.
> > > > >
> > > > > If the PWM cycle ends after 1:, then PWM will pick up old value from 1:
> > > > > which is now in FIFO, 2: and then new value from 3: -- the FIFO will never
> > > > > be empty.
> > > > >
> > > > > The MX3_PWMSR_FIFOAV_2WORDS and default: case is there to prevent FIFO
> > > > > overflow which may lock up the PWM. In case of MX3_PWMSR_FIFOAV_2WORDS there
> > > > > are two words in the FIFO, write two more, old SAR value and new SAR value.
> > > > > In case of default, there must be at least one free slot in the PWM FIFO
> > > > > because pwm_imx27_wait_fifo_slot() which polled the FIFO for free slot
> > > > > above, so there is no danger of FIFO being empty or FIFO overflow.
> > > > >
> > > > > Maybe this can still be isolated to "if (duty_cycles < imx->duty_cycle)" .
> > > > >
> > > > > What do you think ?
> > > >
> > > > Reasonable. Let me test it.
> > > Thank you.
> > >
> > > I have MX8MN locally, so if you need RB/TB for V3, let me know.
> > >
> > > Will I be able to reproduce it on another iMX too? Like MX8MP or MX8MM (they
> > > are a bit easier to work with for me) ?
> > >
> > > Could you include "how to reproduce" in the commit message ? Something easy
> > > like:
> > > - Write this and that sysfs attribute file with old value
> > > - Write this and that sysfs attribute file with new value
> > > - Observe this on a scope
> >
> > I will add it at next version. But I found a problem of your method,
> > especially when period is quite long, for example 2s. Assume  FIFO is empty.
> > [old, old, new] will be written to FIFO, new value will takes 2s-6s to make
> > new value effect.
>
> You're right, for long PWM periods, the application of changes will take
> longer.
>
> As far as I can tell, the method implemented in this patch may still suffer
> from the problem in case of short PWM periods, is that correct ? I think the
> writesl() might help cover some of that.

No way can fix very short periods problem because period was shorter then
register write speed. The register write go through ips bus, which is
quit slow. writesl is equal to writel_relaxed and avoid a dmb(). This will
be over1M hz and user generally use pwm around hz to khz.

>
> Maybe for longer PWM periods (like 500ms and longer?) where we can be sure
> the FIFO won't quickly consume the written data and underflow, we can do
> writesl() with only two longwords {old_sar, new_sar}, first longword to make
> sure the FIFO is not empty, second word with the new PWMSAR value ? That
> could speed the update up ?

We should use this patch's method to read MX3_PWMCNR, if close enough,
write two data into fifo instead of wait for new peroid start.

>
> > The currect method, most time, the new value will effect at next period.
> Yes, right, I think we may have to handle the longer PWM periods somehow
> differently.
>
> I would like to avoid local_irq_save()/readl_poll_timeout_atomic() if
> possible and let the hardware help avoid this, which I think is possible
> with creative loading of the FIFO with data, hence the writesl() idea.

I think it hard to avoid local_irq_save() even use writesl(), writesl is
not atomic,  if irq happen after first raw_write,  FIFO may be empty at
next write.

actually, here have problem

	val = FIELD_GET(MX3_PWMSR_FIFOAV, readl_relaxed(imx->mmio_base + MX3_PWMSR));
	^^^ if irq happen here, schedule happen, when schedule back,

	FIFOAV value in hardware may less than MX3_PWMSR_FIFOAV_2WORDS, but
	previous read it bigger than MX3_PWMSR_FIFOAV_2WORDS, the below check
	will be false and skip workaround.

	if (duty_cycles < imx->duty_cycle && val < MX3_PWMSR_FIFOAV_2WORDS) {


See patch v4
https://lore.kernel.org/imx/20240909193855.2394830-1-Frank.Li@nxp.com/T/#u
It should be little bit better.

Frank

>
> What do you think about the option above ?
>
> My usecase is mainly display PWM backlight dimming, so those periods there
> are in some 100..2000 Hz or so.



