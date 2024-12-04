Return-Path: <linux-pwm+bounces-4221-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4759E3211
	for <lists+linux-pwm@lfdr.de>; Wed,  4 Dec 2024 04:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C1FAB29AEC
	for <lists+linux-pwm@lfdr.de>; Wed,  4 Dec 2024 03:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8A314F9F7;
	Wed,  4 Dec 2024 03:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="tEgWJyg7"
X-Original-To: linux-pwm@vger.kernel.org
Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011032.outbound.protection.outlook.com [52.103.67.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA0017BA1;
	Wed,  4 Dec 2024 03:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733282601; cv=fail; b=l7FOBd9pcgoTQKskS/ItT678P89Ysas9zkd20m/qftGwVuwDww0eN1bDpD0Lo/MVpARQe5aeP8HDRcYwuHLwfezB0u5VAbd9SPWteX7OTPBm6N1avHuvShDBm6Y00qsta+JHOIsKOKihcjuPcA2Cbt7uoXQd/+ZJQQsMej5RrGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733282601; c=relaxed/simple;
	bh=aw3kKwzk90aNKJaAya5tp/LnLs9TY8OJlBs2ra/cw0Q=;
	h=Message-ID:Date:Subject:To:References:Cc:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PufzT7KddMWO3XSkXLdrVNhb9eIpaaDPLNwdmRBT40LsOI77QmXXzC8+DioSIIqheHmpSzvCCkyGZqA4T9xurpPY5Hn2ddo9BlozBTFAzvY9EZShoDKe1R1evaEWIzCe1tNZN1DxyTm7zh3Rx5vgzSlQzf5JBUIRNZ8EhQy+ko4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=tEgWJyg7; arc=fail smtp.client-ip=52.103.67.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qj/VesgACq2oA+Y4w44cY4KcXDb1ahimCI4i9paJh840r+F0s1hl4gOe5w1VjkkFtELvfjkjfFyXoEFgocGf9qoJk0jmhqs5pbUBcyQPAkJejZoT+dMeFr6BjQZnfGkwvGqG8z/4F//76tRksM2yGX+sbNKgKYKvZQus7vp/7uQht0guGZof08l4/GjSzbACypYscjp4OPgTiFdYrUFzyqeChkdCwjvLlBKk3MJdv6JNNu3IskpIKoPghaD6Qi/cnH8vAgF9v7PC4AJ1p2uwsh8/DrCetNFQuo+pWYABT+bpWcb8gwjiLQCcOfhUYj9PCLomZ+e8xL8QmSc6/+lbZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dEIYQkyB4Smd+P+BECZuWMz6OmOagP+INf/nQWIDIJ8=;
 b=jytept3bOjdo/OfP23oECJd6YIAXOF+mrjKZPohuF31zRsbPN17mSOq6NeBbDFp9R1Ju0havrsl8g8kqMoDoIDA75QLLl5aOe/snBo+SxW6/C48w5LLQQssYPDV4j4BYrkVLZGmVNIgGDH2njKbYwY/CZiuhkhMiCIZQNRlLcCxu46X/rx3iJznVygQ4jzRPxKif3/KcFdqZXmIMbnzyHIpNWk/pQSUfrB7wKPNptUqBxUHUAc5DVspNyxXuxMnincYqwg4jS0ppepxgiVTnkbatFB9tKZG8tJrt5buFBDDGPasET1NanMMlkGyJ4R0ckMTAEOIFOQ7HgRNMYnC+TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dEIYQkyB4Smd+P+BECZuWMz6OmOagP+INf/nQWIDIJ8=;
 b=tEgWJyg7H9e3zdNeZYlRwaNdCge0VayOZqRu5CC/XWdKn1nha/2OcIyCNkPT308pyT5BErQoR3+FhIBj3WFLu2CTtRbN1Gr3HJGkPpGYviGX40cNvlqSwHsbStZLVfrHnluTAc6korFWML59TbwMIjMfD+BpU3Cgi+9kO/Xme6CbGH0nVKaN4H/XdOcqAbIPeWi7TtNGmRLDlmIXarMGEdS4dz1xz78KE0QZG8XNX5+BkXMqX7ZhvUzu/zg7oEYBG8uddKOegWkqosQRr4VSseRFgpIhsFfFw4fYidYjvnIUbTb9rWXOT1OLsHk1DPJcyiT7kmD0DJay2sQYhHfYYw==
Received: from MA1PR01MB3979.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:77::15)
 by PN0PR01MB9037.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:164::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Wed, 4 Dec
 2024 03:23:12 +0000
Received: from MA1PR01MB3979.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::8f4f:f03b:c8ca:7432]) by MA1PR01MB3979.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::8f4f:f03b:c8ca:7432%3]) with mapi id 15.20.8230.010; Wed, 4 Dec 2024
 03:23:12 +0000
Message-ID:
 <MA1PR01MB3979DAB77659B77873E009F7FE372@MA1PR01MB3979.INDPRD01.PROD.OUTLOOK.COM>
Date: Wed, 4 Dec 2024 11:23:07 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/3] pwm: Add pwm driver for Sophgo SG2042
To: ukleinek@kernel.org
References: <cover.1733281657.git.unicorn_wang@outlook.com>
Cc: Chen Wang <unicornxw@gmail.com>, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, inochiama@outlook.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-riscv@lists.infradead.org, chao.wei@sophgo.com,
 haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com, chunzhi.lin@sophgo.com
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <cover.1733281657.git.unicorn_wang@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0009.APCP153.PROD.OUTLOOK.COM (2603:1096::19) To
 MA1PR01MB3979.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:77::15)
X-Microsoft-Original-Message-ID:
 <0bace35b-2679-4017-a3b7-a54a3689bd6d@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA1PR01MB3979:EE_|PN0PR01MB9037:EE_
X-MS-Office365-Filtering-Correlation-Id: 8898a657-b16e-4a57-9721-08dd1412fb41
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|7092599003|15080799006|19110799003|461199028|6090799003|8060799006|1602099012|440099028|10035399004|4302099013|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b2xDaHBOaXh1eWNIWm10cS9pbVVCblNJajNIS0toNTN0aXpQMVBIVTdxMjJJ?=
 =?utf-8?B?bW5ldzJ3N2pjNG0vR3pCamNSbUx6UURvRElOTHVVMzJodjdwMy9LTjl5aTBz?=
 =?utf-8?B?blBNcjVvWHpkbTlYNHR6eFZyOVhXUUVjWHpTUWptYkdDanFwdHFiTEdJTGEw?=
 =?utf-8?B?MUJoM2h1UkJ5RStsVGV1UWdzR0h3bE1kNlpiM1ZaVTIwenJVRE9uSmI0eFRx?=
 =?utf-8?B?YmxOOVVCUjluaGEvaG9TREhnWkZkYlpyQjNnREFJY0RWbU9SdmVwL2R3UnlC?=
 =?utf-8?B?WmsrR0lycndyNHN4RDhVVjV2d0djWjU1VkF5b08yMGh2djZZMTZRNDBDZEdo?=
 =?utf-8?B?ejZUb1BZZWUxc3VrVUN2Y1p1RjdpTk9pc2RsZEx6OFArUnRhQnJIQUZ1cnRu?=
 =?utf-8?B?eTdIMTc0V3hHNHlkL2xKMTFsZEllc2oydzFGdnZ6RmdXUTc2WTZyc01ZTVpU?=
 =?utf-8?B?dzZqOTZLdTZiOGswK2pOZFpCTEJlOVN0cTUvc1pkTmJkT0JlWmFwUDJCRGht?=
 =?utf-8?B?TnRTMThDektVbENOUXJ5eTY3aW4wZ1hlekREZzdqRDV1ckFwWHlPWWo1bVEx?=
 =?utf-8?B?NDlPS3ZNU0c0N0ZWd0F2VFRtWlVEdzFINnE0eGV0bjBLMlhUckNCUTg3KzVG?=
 =?utf-8?B?RlhvOXk2bVZCbzB6QURXNWtzUHdZeEY0SW9LTkZFTnAzb0VsekliT1VKdW5Z?=
 =?utf-8?B?VFNpbW41d2xmQjFwZGNuTUJEdmcyVTVkL0hxYlZscXpIK3VNQkEvYUNMNDlE?=
 =?utf-8?B?NUVrWnlTQjFUVi90YkkydHF6aUJ5Nzlvc0tzTWtKQk9CMFdEN1lpdk1SR2ZK?=
 =?utf-8?B?YWR5YmxMdkIrMlZyamc3YzhrL245Z3lwWm43WXVzMUJ5Q2pnTjNOck02alJK?=
 =?utf-8?B?UndxZEd1eUFnYzVienhTUnBrUWdZSTFDWGVwSkd2QVo0STdPTnd5NldvcUJ3?=
 =?utf-8?B?SkhoUUZ3YUdJU2hqZFJPLzU2MnFoL0ZtUjNRdTlRR0JPVzE4Si8zakVNcmly?=
 =?utf-8?B?RzJoeStBZTEwRlhaVHZIV25nYWRlM25uMHhRamNDcS9OT1hOQ1RQbUIvVlVJ?=
 =?utf-8?B?TkdhU00zKzVRYTR5dXdZYmhZOWIwSkZWZDN4V0N6cmFOa2lnLzZGdGhtV2sw?=
 =?utf-8?B?VGl0SzhmNTdlZG1rRVFjYWRBck5kRW9MTHpvaUdETFNGQVN0SCtlcVFNUjh6?=
 =?utf-8?B?ZXZlL21qQzI4OUVFMDRJemtaaTVOVXkva01IWklPSXJaMUdFeXplOHFPMXFp?=
 =?utf-8?B?dmRhQTBKSWdocGk4a05wL1RObXYwQ3h2UHhFc2xWWFhGT1BhZDc2Q2RmYk1q?=
 =?utf-8?B?NEV2dC9vUzQyN3FGYnVxNXJ1eVJzSVdMS3l3aFpXT2U4cDJwYkxxY1o0TktB?=
 =?utf-8?B?OGNCNWU4NFQ2ODU2UWF1MUwyTFZqZUJobnBpZ3J6WFI5NVhoMzc3YmxTblZP?=
 =?utf-8?B?OURKdUwweC9nTTAvbFRwa2xkaUZiQTFqVXU1YlE2SmorcTVNcjdvWWZMYTRU?=
 =?utf-8?B?Wm84SVlPNUpwRlVHeHNvT2crTzBDbHJYUVNXVGVvZ0JwVXNjU0hWVzcxNDJv?=
 =?utf-8?B?aUR5TDZhbFhNMjFOelQvblB1NFpwaVNGVDZFNXlTbjExVVZQOGZEUUw3ZDFB?=
 =?utf-8?Q?bNy+K/SG6Jn0Tb8XskzNH7V17txBJ/K0MhfcpKDEq7HE=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ti92bml4RXVudGFVblRSWXNmQzlpSDByNG9BL1NaR05qT3FIVmZkSGYxOXZu?=
 =?utf-8?B?SEw5QlVTaERJUFM0QnVpN0xnZVJkOXVORHE1a0JBc2RUb2JiZjk4aXZBbUor?=
 =?utf-8?B?U25rbmFuWVppREZpUFoySDVyNjUyZU1xY1dYTHAxaUJmOE5OOTY3U3Evck5q?=
 =?utf-8?B?VzBXeU1CemRXcTl0Vms3OWlQWnFDdVkzZzhWM0FLVWxqK0R5dkpSWEtBR0k0?=
 =?utf-8?B?cDdyZ00xQ1NrbkdDZzBOVkVJMVZNSXllUFJ3Q1BSSVlXWVNQWEVqNjNoUFRC?=
 =?utf-8?B?ZWdwUnNoZVBqLzNLeUtNNXRFQ2JQQUJKWDFKYkVwTUhpQy9mZEkvTmxYNEsz?=
 =?utf-8?B?VXpMbU5wOUJRcjV2TlZXVWdjOGtMa2pSYWtnRGo3elhLR3VJcHdkV01ZR0ND?=
 =?utf-8?B?VXdVZlJNUXpvbmttMEtSUVdvUjRWVXdKVHN0VzArcjkvYWFMUzFXbXo1SjdR?=
 =?utf-8?B?YlNjUjBLQVlQYUVuVDBHL3dmMEJTOFdhYTRvVkZjWjVKZGNmU255UmNBcWNH?=
 =?utf-8?B?V2tFenkxZ1J1UGNhd2VWSU1lanB6enNuTkNXUklLTDVFOG5JLzkrOEIyWmpq?=
 =?utf-8?B?OEl3TzFsRHA3bzdYZmNXMlQ2YXRkM1d4YUZMUk5kRUhCS09wam5VOTJNVG5L?=
 =?utf-8?B?TkpxVWZBbkZ2VDNqQ3cxVUQ3L2lNbzJldUh1Tm9jeFBjVEY4amgzaHpBQWlt?=
 =?utf-8?B?VFJlMUxkY1cyeUNaM2xHTjBoN2xlY2FVUEhKcmxucCtLa3VGUHpaMklYVUpK?=
 =?utf-8?B?ZEQ0Sk5BZyswMWtwc2E0cjIxdG54clNLNUNIbVpybkhxaytzS3pibXZBQTRj?=
 =?utf-8?B?WG5DRmlEbVl2dTFQOFF1aFRsZTVtRDJUU0pLQ25KdFB1NTQ4bkhZZlB6QVZY?=
 =?utf-8?B?cVVNVzRJZnhGSUtQODdwc2tuYW0rbUZsYXNKTVVDR0NwTkdET2ZjMEF6U1pL?=
 =?utf-8?B?YWJYZUhuMUZ6R0ZrVFl5VFhUVU1rRllOajg2bEZoZ3FzcExLdEFwNm8wOXQ5?=
 =?utf-8?B?ZXdPRDY1eHdFZTFMbE5GMzU2K29zb3NkczVLNUk1YWEzU1JMZ21HNnVkQldX?=
 =?utf-8?B?WmJaUUFJVGVTcjlLMzZyWEhQbWx0VVRJZmxOWG5RRzBQVzdtWEtJdDRuWXho?=
 =?utf-8?B?bTZ2NWo5NFBiSDBGMllTNUd5L0YvdWxkQXdXTnd5eXFvV2dNUnJwRU9YQWQv?=
 =?utf-8?B?QzhLcEVIeFVjRjZBcmovNU52SWJQa2dVV3ZwTHR5Vk1iUUFGNnc0YkpYTnFQ?=
 =?utf-8?B?c1JGZkhMaGFtbHpsTVhMZkYzdm1wd05GeWM4SGljVXpkVVNXZTFJSDBQSm9Q?=
 =?utf-8?B?MEZ2akhISVFqZWNsMHg3Sm5FT2MyMVRZK2VGTlJ0bGhGbDYySnNQK09hSnV2?=
 =?utf-8?B?T2RTbDlnVjFYYTBYbDVJOGlxVUJBYnhuU2lLRzFjcXM2MXg2eHhvL2xKaXY5?=
 =?utf-8?B?bkordzhmMUpzOEZMMmdkZUoyZGpGMnlJS1EvOGt5alVsbGFMQk9xY1N5Y2Mw?=
 =?utf-8?B?OXN1L25ZYWk5NnEya09HNGlIUzVXZUo4cVR4elc0c2lpVVNRVGdFK1RVSHd4?=
 =?utf-8?B?TUp0aTFMR0J1ZXJiQldSUm1BajdlenZQUUN0RmdGZ1JqWVpLdUQ5REFaNHdy?=
 =?utf-8?B?d3Q5aEIxMW1jL2V5WFNDOVFiQXlYTnFiRXl2d0ZGSk41Z0wxMG1JeW5id3NE?=
 =?utf-8?Q?keIbzQg+Ji8Nkb5q2Zsk?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8898a657-b16e-4a57-9721-08dd1412fb41
X-MS-Exchange-CrossTenant-AuthSource: MA1PR01MB3979.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 03:23:11.7674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB9037

Hi, Uwe,

I just upgraded this patchset and rebased it to the latest v6.13-rc1, 
hope you can merge it in v6.14.

BTW, you just please handle the bindings & driver part, I will handle 
the left DTS part.

Thanks,

Chen

On 2024/12/4 11:15, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
>
> Add driver for pwm controller of Sophgo SG2042 SoC.
>
> Thanks,
> Chen
>
> ---
>
> Changes in v6:
>    Nothing major changes just rebased onto v6.13-rc1 and retested.
>
> Changes in v5:
>    The patch series is based on v6.12-rc1. You can simply review or test
>    the patches at the link [5].
>
>    Updated driver to add resets property for pwm controller node as per
>    suggestion from Inochi.
>
> Changes in v4:
>    The patch series is based on v6.12-rc1. You can simply review or test
>    the patches at the link [4].
>
>    Updated driver to set property atomic of pwm_chip to true as per suggestion
>    from Sean.
>
> Changes in v3:
>    The patch series is catched up with v6.12-rc1. You can simply review or test
>    the patches at the link [3].
>
>    Add patch #3 for dts part change.
>
> Changes in v2:
>    The patch series is based on v6.11-rc6. You can simply review or test the
>    patches at the link [2].
>
>    Fixed following issues as per comments from Yixun Lan, Krzysztof Kozlowski
>    and Uwe Kleine-König, thanks.
>
>    - Some minor issues in dt-bindings.
>    - driver issues, use macros with name prefix for registers access; add
>      limitations comments; fixed potential calculation overflow problem;
>      add .get_state() callback and other miscellaneous code improvements.
>
> Changes in v1:
>    The patch series is based on v6.11-rc6. You can simply review or test the
>    patches at the link [1].
>
> Link: https://lore.kernel.org/linux-riscv/cover.1725536870.git.unicorn_wang@outlook.com/ [1]
> Link: https://lore.kernel.org/linux-riscv/cover.1725931796.git.unicorn_wang@outlook.com/ [2]
> Link: https://lore.kernel.org/linux-riscv/cover.1728355974.git.unicorn_wang@outlook.com/ [3]
> Link: https://lore.kernel.org/linux-riscv/cover.1729037302.git.unicorn_wang@outlook.com/ [4]
> Link: https://lore.kernel.org/linux-riscv/cover.1729843087.git.unicorn_wang@outlook.com/ [5]
> ---
>
> Chen Wang (3):
>    dt-bindings: pwm: sophgo: add PWM controller for SG2042
>    pwm: sophgo: add driver for Sophgo SG2042 PWM
>    riscv: sophgo: dts: add pwm controller for SG2042 SoC
>
>   .../bindings/pwm/sophgo,sg2042-pwm.yaml       |  58 ++++++
>   arch/riscv/boot/dts/sophgo/sg2042.dtsi        |   9 +
>   drivers/pwm/Kconfig                           |  10 +
>   drivers/pwm/Makefile                          |   1 +
>   drivers/pwm/pwm-sophgo-sg2042.c               | 194 ++++++++++++++++++
>   5 files changed, 272 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml
>   create mode 100644 drivers/pwm/pwm-sophgo-sg2042.c
>
>
> base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37

