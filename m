Return-Path: <linux-pwm+bounces-7388-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0022EBB6226
	for <lists+linux-pwm@lfdr.de>; Fri, 03 Oct 2025 09:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 977314E4C98
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Oct 2025 07:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D45228CB0;
	Fri,  3 Oct 2025 07:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="O9tWvjDb"
X-Original-To: linux-pwm@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19012010.outbound.protection.outlook.com [52.103.14.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC20226863;
	Fri,  3 Oct 2025 07:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759475222; cv=fail; b=cv18IIJDq/pNcj3Kx26QB3TQNWy7BEYJ2hrV/c3E4zHG2CbLdT24Z0tsVcUG8taFsNZ9H/6YZknfAV450y9RrUpF0pPaHnAz5UE7EZQFLDqTi0wIsCHe7Fa+iBGXWSjRjOsdJw3OGUCvetEbEE1sBcAR0caWm+K2v3BxUQ9TpcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759475222; c=relaxed/simple;
	bh=gQY7rCb5fjx4ENpigI4vIUsFbEHMjVF6nzkB87wJuic=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DiNBTRC4NXaHs7ywDTV+LFp5OL5GFlk79LadvCBvIZZpVR6Cx7josChA/QbJOxOk96374eygr6ZTfjX/Qpf+47C6Q6hmWNQyMynFMf+ov8+KyPMqk8J6YToqDM0hKy2gdXrrV9HRhSR3TmfVSsyi5NPY+e8NNsfuZgY6br2INu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=O9tWvjDb; arc=fail smtp.client-ip=52.103.14.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tM1oSLYBFH/KGgxZl2nsevhxsWYwB3SfXWuiZ6sSOVo3yGNKYghn7jq9/s54U7gVW6X+VxeVTmH93U/s6DaM5Zxoldhc/QGy+N76O6jvYX8DvwqV9WNeQEW3/02D6gBFEHCdClw72ArF/aPh5JED672P7nXiZQvf+XFvlcKEWRn+uV2mWBsSKKHXTOnYpLC5su5phnhwqnVyhgOOzF2Nz5Q9PlvGwD9nO2GGKEA7eY/msxzl7ZVzJMCrEnLhKmYqdyPc5P32u5WsgEkIV6SeECjE31ocxfZqgLZ9kftUoGaQZobscf7SuWbsDIDv2JBFQAzewVbf2RsYJ51Tqr/XFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t8SO8S3DK66GXPx8qiUoP7FoH8SVKXhUZ6N4uqbJer4=;
 b=wGiD79uLDkP1skLtyk+O8T2eVoV8WxsxFn/gtGmHUaPdaE/SfpHhprdP9TGgmMNbM9yk5J+IFRMQOWRreW/jynC7TJIA1SNCqflzXbrQOLE9q35C5lE9P8kli2LaRHSWkhbCiOFIGE46M2WPGH3fOk6hvdFB8JhgAh4Jj7uCTx5/+i5uExMaPSjXZFe6YC82FKbHkS6jCMzBGF0YtyTwqZNFZfsqoBsh3cV9bg89Q6W5CC2MVaXBkODlBeOUJTdnqNks8dEaoTE6LtB95IxaaMYMvQ9W7iLUgLG70DPqu3hkVF6QPuQrAFMw7y/HD5Soj7HHplOgLf0SuXCGK6LDRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t8SO8S3DK66GXPx8qiUoP7FoH8SVKXhUZ6N4uqbJer4=;
 b=O9tWvjDbzQMwwFo3kuyN3ygfKm5yKXuB5nSiE1QubYJfD2toEQr2fQXs4OdOVNHnwxgimHD6P8XQoveLsfVs6mL1c/FIIZLWycBrZkt0FDtIQN888CNbJmWhGNQ+BKhY3Hd2AhT2Yx9xw7wQhXX3pZ5hYxbwIWaiHJ75tTjQ/OxXF5jsIql+ILk/0C0mAzoRFXod3VhokQd4dt8DY/HozhmQIFdT3jcQO1BQZqaF02fkSgU4j18PjmoKfFjTCvtBr0gCHzsDCW9OBv66Zv6M2qyWdxWFiTJ8JoHApgVQgh6z/943dekWwB4GWFZnaIFkrEr38tcdFMpYpg6XSSfFzQ==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by LV0PR19MB9496.namprd19.prod.outlook.com (2603:10b6:408:321::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Fri, 3 Oct
 2025 07:06:57 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%4]) with mapi id 15.20.9160.017; Fri, 3 Oct 2025
 07:06:56 +0000
Message-ID:
 <DS7PR19MB8883CF5D3DA8ED32B6A919449DE4A@DS7PR19MB8883.namprd19.prod.outlook.com>
Date: Fri, 3 Oct 2025 11:06:46 +0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 0/9] Add PWM support for IPQ chipsets
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Baruch Siach <baruch.siach@siklu.com>, Baruch Siach <baruch@tkos.co.il>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Devi Priya <quic_devipriy@quicinc.com>
References: <20251001-ipq-pwm-v16-0-300f237e0e68@outlook.com>
 <175936202881.2426650.1624694657690403545.robh@kernel.org>
Content-Language: en-US
From: George Moussalem <george.moussalem@outlook.com>
In-Reply-To: <175936202881.2426650.1624694657690403545.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DX0P273CA0105.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:5c::16) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <45a1a0bb-605d-44c1-ae94-403545535a91@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|LV0PR19MB9496:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a7464af-ebf3-4a6e-8e7f-08de024b6ed6
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5072599009|8060799015|19110799012|6090799003|41001999006|23021999003|15080799012|12121999013|3412199025|4302099013|40105399003|440099028|52005399003|10035399007|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S1JMK05YNEFaNjdyU3NGNnlnTEtDeUUvSlJjTUw5cEQ4K2dGazA0NGY5VWd2?=
 =?utf-8?B?OFcyc09QQ3hHbXVHRmgyVDRHTXN0TmdJVzVqZDhyVVlKZGQ1STdtYlpWYlY0?=
 =?utf-8?B?UWg4MGQwNmZ5d0Q2akk1c1hBV3hscFFTeWJSaXBvZmhDQkhyYnR6MmpUZm93?=
 =?utf-8?B?WEVCODFJZERQV3pQN3A0bUpiSUpXWmxkbUJTYXpiZVhWbDBSdVpiS3QxR1hJ?=
 =?utf-8?B?RzhXeGtjNytTa2ZtNldJTkVocG1pTDNaeVJBY2dXc2F5eE1jS1ZTcFRDcUQz?=
 =?utf-8?B?a1p3SjNkREVQK1JvVnhwNk9POUxjOWg2QzZibGxIb1I5L1NHS1J3WjBSZE9H?=
 =?utf-8?B?SHkyWkVQMHIzb0JNM2t3OTdVS1BGZWpQa2VWNlhMczFTUXVoRFZ6dS9DN1g2?=
 =?utf-8?B?MVdNTUFMQ1FFUmNlMGlCcGhzMDZvU055UEsrV2dSMU4yVFVzaE5oem4wdE83?=
 =?utf-8?B?RDdrVVloUG90MVVTYk82MW5RYTI5UUhwbkUwUVBUOXVlS1d3VXhocG9QRFU1?=
 =?utf-8?B?SGRJLytTZHlJTUNPMXpiM2JoejNIWlYxNEJ4bXJrWlRzSFYxZFF3VEJvdGpx?=
 =?utf-8?B?SGdJeURBMXV1aXZKUGs2QUVnS04xemEwajdhQ2hsRkw3dURVZkFkYVlkUU9q?=
 =?utf-8?B?bkdlK3VhNHBUNGFKWG5INGo0OC8zVUltVnRyVUZZQTdaay9laGEyOXRhUmx2?=
 =?utf-8?B?N2x3SXo3c2laTktZRzAzL0JoRExCQkFSOCtYcmxHdWtWZUd3NCt5aVBCbXds?=
 =?utf-8?B?MDdZTFVtMlI5VjhZMnBUc3l4OXY0bXlhOEhtVTA5RDdMR21GRzVMUnFGMlhD?=
 =?utf-8?B?SDZjVStNQnltV1Q2RDFGL3BTV3JvUC9vQXpxRCtVMW5BamUvcGdKdGY1MWFH?=
 =?utf-8?B?bkFJNGVQVXB0clFBek5ZaXhOYWFydUxSNjllejdzWEtKVnhtYUhsaDlDNlYx?=
 =?utf-8?B?bWlqV0dnK1JmT3hRdTFjdnhIZnRYWnpCamdheVFUeERxQVBVa0E0ZFk1Z2tF?=
 =?utf-8?B?YWRUQ1M5ZjdBcnVncEI2cUh6eFNVT0NVZnhna3NCakkraFZlM0ZLSlhkRlc2?=
 =?utf-8?B?dStFcEl3Sk04RkFJNHJ3cUJXQkJJOWNWVzRrclQ2aTN6QU9ISkEyKzJBc0p2?=
 =?utf-8?B?TTJacjZyRTBTSjlRRzhDeGo4RndHcWRuVUVYd3VNVTlmSm1peEs5R2lWWXl4?=
 =?utf-8?B?VHg2TDBDc2JBdmFLZWppVmpwb05yOTcxYXVZek1mVFI4OTQxUi84b2d2MzBO?=
 =?utf-8?B?K3BlSXlRQUpUNTU5bDZDWDZDRExWbHJzbjRDdEgyRTBRcU5SNHRlRmxGOSta?=
 =?utf-8?B?ZGtSeGgvYmNzaWVabUJIcHY4alZCV2dZM013YU15OTFXaHQza1RZZENmVEhm?=
 =?utf-8?B?WnpScnZrRUNwZG1OSEdXblM3OHhEbGJ0ajd0alpGVlFaS2dYOXpiTmpqQnAx?=
 =?utf-8?B?Q20zRy9LM1lydUNyMzNiemk3OWpFdk03NitaVHo5blNGcjJ2YXQvRW5mdGJv?=
 =?utf-8?B?QzJaUzZwK0RwT2VCelBzb2M3cVY0WGdOUmpYRDNsekVHTGVJOGx1cTFBaHI2?=
 =?utf-8?B?WHJUNjVSdk02ZmVCSlNZT0gwVzh6cXVCL2pmSmJFMTN5bHBrMlhUa2dUaE96?=
 =?utf-8?B?eWRpUW9kbVNGMXNxU2dqNkJEODIrc0UwRnZSVG5HZ3g1dmc4QWF1REphQVZV?=
 =?utf-8?B?RG5jd09OS0czdTIxaklYV05WWkluNG1BYVBFb3BHZmYydnBFaXRYdTBCNHNW?=
 =?utf-8?B?WUJERWRRZHprM3JBRkw4TEJWQ3RMWDR4TlRFTWJVa0hnVFJ5K0RxTWI4ZFdC?=
 =?utf-8?B?S2wzcklyRlNON0RZZDE5Zz09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K3Fmb1U4dHV1NWl3cEdIWW1xZUh0OXNZM1o1S2o4RTlFbzAybXdBN3FqRGJC?=
 =?utf-8?B?ck9TS0JvZ3BCeXdLZFowUS9rNTcxZENBYXpEUm11MnltemRYV3h0OTBzZmV6?=
 =?utf-8?B?OXAzRDBabmlhUk1MT0RuYURWNmVNU08yYWNOa3d3L2h4dVF6Zk5aQzdNNE9J?=
 =?utf-8?B?dDREbzlTa2IzSU9vbTh6cXJXdFM2MjRYdnBNVktrOVJNbjl3RUhEUW92OU1F?=
 =?utf-8?B?K1BHc1hTV1BOTmZZWTJhbi9pVTBXbXZaakZMbXFjU0t4SnM2L052c1NGUWNT?=
 =?utf-8?B?YWdkRE9UUExlT2FCZnhiT082aWlYcFF1MDUyc3BjM05WaXBHSDVzNm5uZE1B?=
 =?utf-8?B?RWVra3R6OEp4N1lib2ZWUXRNSnRjeUxidTJLclozNEM3dGhoNFU4cHFRNUZE?=
 =?utf-8?B?Y3g4MWlJbiswTFFuVlRyLzhvMks1ZTVWb3E5M1V6TlNmM255Z2llK0d5bjlQ?=
 =?utf-8?B?RUNGVkF1dW44TklNNXVUWFpvL0VWNGVmTXhkU3kzbWw2L3NZOURqRmVTdVdS?=
 =?utf-8?B?ZVFjWVhJR3lpKzFJa1hscjBjTzlpZ3NDdkc4dWYwWGFUS1VWc25pRUsxbGgy?=
 =?utf-8?B?NFF2RjYvSTVaTGQ5b200VzlTZ1pBRk1XanRsSGFNb2NBclRpcm1rNEJrY1Fs?=
 =?utf-8?B?WE5xdTR3ZWc4MkFMd0xVb3NUWGtKQk9LQys1QWFFeW9uU3hQZjBHdGZCRDEz?=
 =?utf-8?B?REp3VDJ6RmNCdldraGthR2o3elJlR2NpcVNIYjFmelRUc1l0cWV1bXlqRGp0?=
 =?utf-8?B?NlVhYUIwazJ3cWFwRFhVemJEVUNsRXdtaXlYQ1B2QjZNVDIrYno1VmU0NGF1?=
 =?utf-8?B?aEMzeUFSMk5adE9oV0xTcmRmZjk5bzhEYWJKdEpMZ0xYcFVOSjYyUFNCV2xq?=
 =?utf-8?B?RTdZVmNPYkUyNWZJeURaNU1nMjVkdmg3a0FLVXpxc0FZWXVpYTZKWm9KMlp6?=
 =?utf-8?B?Qkl3V1FoV3VjYnlzRC9ZaHNFbTVTUlAvSUR1SHl3dEdWR1FFS3hVZnAxdjV4?=
 =?utf-8?B?OVlVNzZ2WVpWRlptSENWL0tIWDE5S0d0WkppNXlUU3VpOGdGVHlQSnAxQ2xr?=
 =?utf-8?B?ZjNHTjRvcXZaSlBqNE1XNk1uYmV4NEFmZW5qL0MzUGNCQmUyYlFPbDNlbWRL?=
 =?utf-8?B?ZkVXSXVmeCtmSG5NYmJORlExanhEcUNOaXQ5RjRhZzFhK2RBSjgwYi9ldExu?=
 =?utf-8?B?ZEpwaWNBeG5uR0d6dEdPVjM4WWN5eE1nQmZPRkN5elJQYmw5RzFJUGFGZUQr?=
 =?utf-8?B?bDA5YTFqMXFZWERBNklob1FDZG52VjBVMFpzZml3bFh1Z0FkWmcwcXo1OEZF?=
 =?utf-8?B?bUxZOWhoc0tXbVBhbFdld0FmTDdjYUhCMmhuY0ZObGh6U1pORzlhM3RlYjhr?=
 =?utf-8?B?V1RVbUpMa1FrSVh5NEpWOGhxM3JjOXFSak1SNU5zVkFjMFRvakNLMTNTcTFz?=
 =?utf-8?B?cWs5cGQxZlMvbHZuanFzUE9wUW9oOWRGOFdtUG5wZzZFcjBhalVOalZvSDFB?=
 =?utf-8?B?cHlTdklzTDlWSktyaTFjN2ZIWGtLcjdMRzFQNWcvejV2MUNPaFpSNmNPaENK?=
 =?utf-8?B?ZDRydG45UmcwQmtWaTc2eDdjcUk2ZEt0emt6TGd0RDJiNWY1V0FrWlZVRFFs?=
 =?utf-8?B?UXdqUUV0ZGFQSGVDSERtZGtvL1UzZWdKbGNHQjZGOWhrTk5uNW8wSVVlR0M3?=
 =?utf-8?Q?d329ChCVRJBbesPmo5nR?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a7464af-ebf3-4a6e-8e7f-08de024b6ed6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 07:06:56.0118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR19MB9496

yeah, my bad. c/p error as I moved it out from the TCSR node.
Ran dt_binding_check on the yaml, did dtbs_check on ipq5018 so missed it
for ipq6018. Will be fixed in next version. Waiting for feedback on the
driver (Uwe's?) and on the dt bindings (Krzysztof's?) for adding
additional compatibles. Will then send out the next version..

thanks!

On 10/2/25 03:42, Rob Herring (Arm) wrote:
> 
> On Wed, 01 Oct 2025 18:04:16 +0400, George Moussalem wrote:
>> Add PWM driver and binding support for IPQ chipsets.
>> Also, add nodes to add support for pwm in ipq6018, ipq5018, ipq5332, and
>> ipq9574.
>>
>> I've picked up work based on Devi's last submission (v15) which dates
>> back to 05 October 2023 as below SoCs are still active.
>>
>> V16:
>>
>>   Removed reg description in bindings as the offset is not relative to
>>   the TCSR region anymore since simple-mfd support was dropped and PWM
>>   nodes defined as their own nodes, not child nodes. Updated the example
>>   too.
>>
>>   Dropped patch to add simple-mfd support to the qcom,tcsr bindings
>>
>>   Simplified code to calculate divs and duty cycle as per Uwe's comments
>>
>>   Removed unused pwm_chip struct from ipq_pwm_chip struct
>>
>>   Removed unnecessary cast as per Uwe's comment
>>
>>   Replaced devm_clk_get & clk_prepare_enable by devm_clk_get_enabled
>>
>>   Replaced pwmchip_add by devm_pwmchip_add and removed .remove function
>>
>>   Removed .owner from driver struct
>>
>>   Added compatibles to the bindings and nodes to the device trees to add
>>   PWM support PWM in the IPQ5018, IPQ5332, and IPQ9574 SoCs
>>
>> v15:
>>
>>   No change
>>
>> v14:
>>
>>   Picked up the R-b tag
>>
>> v13:
>>
>>   Updated the file name to match the compatible
>>
>>   Sorted the properties and updated the order in the required field
>>
>>   Dropped the syscon node from examples
>>
>> v12:
>>
>>   Picked up the R-b tag
>>
>> v11:
>>
>>   No change
>>
>> v10:
>>
>>   No change
>>
>> v9:
>>
>>   Add 'ranges' property to example (Rob)
>>
>>   Drop label in example (Rob)
>>
>> v8:
>>
>>   Add size cell to 'reg' (Rob)
>>
>> v7:
>>
>>   Use 'reg' instead of 'offset' (Rob)
>>
>>   Drop 'clock-names' and 'assigned-clock*' (Bjorn)
>>
>>   Use single cell address/size in example node (Bjorn)
>>
>>   Move '#pwm-cells' lower in example node (Bjorn)
>>
>>   List 'reg' as required
>>
>> v6:
>>
>>   Device node is child of TCSR; remove phandle (Rob Herring)
>>
>>   Add assigned-clocks/assigned-clock-rates (Uwe Kleine-König)
>>
>> v5: Use qcom,pwm-regs for phandle instead of direct regs (Bjorn
>>     Andersson, Kathiravan T)
>>
>> v4: Update the binding example node as well (Rob Herring's bot)
>>
>> v3: s/qcom,pwm-ipq6018/qcom,ipq6018-pwm/ (Rob Herring)
>>
>> v2: Make #pwm-cells const (Rob Herring)
>>
>> V15:
>> Detailed Change logs are added to the respective patches.
>>
>> V14 can be found at:
>> https://lore.kernel.org/linux-arm-msm/20231005043127.2690639-1-quic_devipriy@quicinc.com/
>>
>> Devi Priya (4):
>>   pwm: driver for qualcomm ipq6018 pwm block
>>   dt-bindings: pwm: add IPQ6018 binding
>>   dt-bindings: mfd: qcom,tcsr: Add simple-mfd support for IPQ6018
>>   arm64: dts: qcom: ipq6018: add pwm node
>>
>>  .../devicetree/bindings/mfd/qcom,tcsr.yaml    | 112 +++++--
>>  .../bindings/pwm/qcom,ipq6018-pwm.yaml        |  45 +++
>>  arch/arm64/boot/dts/qcom/ipq6018.dtsi         |  15 +-
>>  drivers/pwm/Kconfig                           |  12 +
>>  drivers/pwm/Makefile                          |   1 +
>>  drivers/pwm/pwm-ipq.c                         | 282 ++++++++++++++++++
>>  6 files changed, 435 insertions(+), 32 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml
>>  create mode 100644 drivers/pwm/pwm-ipq.c
>>
>> --
>> 2.34.1
>>
>> ---
>> Devi Priya (3):
>>       dt-bindings: pwm: add IPQ6018 binding
>>       pwm: driver for qualcomm ipq6018 pwm block
>>       arm64: dts: qcom: ipq6018: add pwm node
>>
>> George Moussalem (6):
>>       dt-bindings: pwm: qcom,ipq6018-pwm: Add compatible for ipq5018
>>       dt-bindings: pwm: qcom,ipq6018-pwm: Add compatible for ipq5332
>>       dt-bindings: pwm: qcom,ipq6018-pwm: Add compatible for ipq9574
>>       arm64: dts: qcom: ipq5018: add pwm node
>>       arm64: dts: qcom: ipq5332: add pwm node
>>       arm64: dts: qcom: ipq9574: add pwm node
>>
>>  .../devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml  |  51 +++++
>>  arch/arm64/boot/dts/qcom/ipq5018.dtsi              |  10 +
>>  arch/arm64/boot/dts/qcom/ipq5332.dtsi              |  10 +
>>  arch/arm64/boot/dts/qcom/ipq6018.dtsi              |  10 +
>>  arch/arm64/boot/dts/qcom/ipq9574.dtsi              |  10 +
>>  drivers/pwm/Kconfig                                |  12 ++
>>  drivers/pwm/Makefile                               |   1 +
>>  drivers/pwm/pwm-ipq.c                              | 214 +++++++++++++++++++++
>>  8 files changed, 318 insertions(+)
>> ---
>> base-commit: 846bd2225ec3cfa8be046655e02b9457ed41973e
>> change-id: 20250922-ipq-pwm-c8c75c147d52
>>
>> Best regards,
>> --
>> George Moussalem <george.moussalem@outlook.com>
>>
>>
>>
> 
> 
> My bot found new DTB warnings on the .dts files added or changed in this
> series.
> 
> Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
> are fixed by another series. Ultimately, it is up to the platform
> maintainer whether these warnings are acceptable or not. No need to reply
> unless the platform maintainer has comments.
> 
> If you already ran DT checks and didn't see these error(s), then
> make sure dt-schema is up to date:
> 
>   pip3 install dtschema --upgrade
> 
> 
> This patch series was applied (using b4) to base:
>  Base: using specified base-commit 846bd2225ec3cfa8be046655e02b9457ed41973e
> 
> If this is not the correct base, please add 'base-commit' tag
> (or use b4 which does this automatically)
> 
> New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/qcom/' for 20251001-ipq-pwm-v16-0-300f237e0e68@outlook.com:
> 
> arch/arm64/boot/dts/qcom/ipq6018.dtsi:418.4-28: Warning (reg_format): /soc@0/pwm@1941010:reg: property has invalid length (8 bytes) (#address-cells == 2, #size-cells == 2)
> arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dtb: Warning (pci_device_reg): Failed prerequisite 'reg_format'
> arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
> arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
> arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
> arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dtb: soc@0 (simple-bus): pwm@1941010:reg:0: [26480656, 32] is too short
> 	from schema $id: http://devicetree.org/schemas/reg.yaml#
> 
> 
> 
> 
> 


