Return-Path: <linux-pwm+bounces-3152-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FBE970ACA
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Sep 2024 02:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 827101C20A7E
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Sep 2024 00:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECE46AAD;
	Mon,  9 Sep 2024 00:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="K4Od1vjg"
X-Original-To: linux-pwm@vger.kernel.org
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2026.outbound.protection.outlook.com [40.92.102.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1B979FD;
	Mon,  9 Sep 2024 00:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.102.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725841775; cv=fail; b=VmePLraj5HrYFE5SrMWCggrmQmBmVB2EUNyc1mFxvBS7+9cpHJZ2qtZ09ezcXsHbRefi2Xv+POLhE/WxGcmVp0ypDLPDaRzD66iJUDVtA24hshtgRHqnYhd+aIju55eSS7p1kXAcxykXdeXIx1DjpTl5fHIi7/M8BbQvt7tTD2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725841775; c=relaxed/simple;
	bh=AvdRPJDGAivMlhczHbYaG+Mw731I5OY7GADmGWDPjrg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kEOFBEPf6B47fQPb70UG0X1v1jFHi+zfzTZWtJ6JMhgignrrpghQjI3aLk4gXLdxKJG0m///9UgvKOH/RNecfHqtciWGyNdVYpQJNZAwVxbZNb4a66jsyybh48pbJ4cAD6RXiWgCZXPBJdrtlTZwprR+NaZ5Z5u7wd9uRLQvdQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=K4Od1vjg; arc=fail smtp.client-ip=40.92.102.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mUBzOSRX5zPW4FwWEogWuofsfxTZ7FMbkyHKSu4lvbuOrIIGqjepkjZeuGZC6wAKUdX6oKI5iz+oVTPtSmfEm0UNBzyXwDjpyzTjlmpCGFS8ktiWlbA0kIWA/FmxlcMWQCuJOHdQp8Btj4xrjqXz64+NxVpNhVgY0+UvC02WkkaN5Qzpkc8EPYSnmiDF7aziuW15sqkCjBpuZmcB9OvnXLs+p8fgLfkA3utj2+uu1o/Z3IbfrhlSnZ4Mg0W0VJ7i1eLL6VrYrojC9Gy8JutvzNLZLA2Zas6XxNQspaBVB+R2AOZzLqPZOkcWMzuuLEud8PxW0Z9tXPtyKRFuIvrP9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XBDF3ze7Cj4nScaXHZ6M8qtl688MJuVP0rCq2nuw8yM=;
 b=FJ3jzQlLwXkHYIJaLCU2F6LKS1DEFZAYBgMcfIr1tcQ25n367Pyrb027k/8kK+CJfrfJhMXRyq0WDF+P056HaTRnuefbSUIaJ4ROndlz4rK6mkv148bKsbGeYZlmeOaox14paLAu8KxTnGHfHj/NgboZ/Me3MhHwN0yhbErtqwqnFSEkjJ4nb4va080p4fjCCh1dqdMz2OGM9ezu3AQ+PlwlG6o6JAp9z00tJlXkofwyeFqUrCYzwvGXWWPtjdoUZZF8pBG6NPTC/HjQOeqSH6xEGnywvcCh60H0XBwYEpo3JBBh9X0nWUtk2XkZxFKoqbmFfQeBu2CJHVQLi5f/XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBDF3ze7Cj4nScaXHZ6M8qtl688MJuVP0rCq2nuw8yM=;
 b=K4Od1vjgNm5gdaSaB2/tRS2h2pChAYBXNnF0gbZTAEYWWgZUl5kguUunISD03lrMUXidPZ/v2xwdZt4oWWKweJccfHdRWJpMXG22v9ERaK9I0xAjN2TRuNq6WW4FC++e4gYQSSQ5nh7L4uqroRhWURJjjyxcN3OyTDm6EGCT6vn4Gor9tCEtsXajhySHIZ8jsPyYEIt3uZUNqRObQVM+v5Fbxd++lm2DibNQExIChVAJam76v1mbLMYhtQtugUoeKEyI2Db399sD1vT6dLwRxnyBMfb4H1Js5mvi6AtNuEF3PWiwzxxFdu//46UzRdiDq90aXU2LV/aVZzgsoNPOkw==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by PN3P287MB0354.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:d8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.22; Mon, 9 Sep
 2024 00:29:24 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c%4]) with mapi id 15.20.7939.022; Mon, 9 Sep 2024
 00:29:24 +0000
Message-ID:
 <MA0P287MB28227F2A65ADCC493499B7CEFE992@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Mon, 9 Sep 2024 08:29:15 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: pwm: sophgo: add bindings for sg2042
To: Yixun Lan <dlan@gentoo.org>, Chen Wang <unicornxw@gmail.com>
Cc: ukleinek@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, inochiama@outlook.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-riscv@lists.infradead.org, chao.wei@sophgo.com,
 haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com, chunzhi.lin@sophgo.com
References: <cover.1725536870.git.unicorn_wang@outlook.com>
 <6e5fb37472b916cb9d9abfbe3bea702d8d0d9737.1725536870.git.unicorn_wang@outlook.com>
 <20240906024435-GYA153340@gentoo>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20240906024435-GYA153340@gentoo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [r69EZut5XYbg2Gpv33Dmwx4k7CGMkBGp]
X-ClientProxiedBy: TYBP286CA0007.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:ce::19) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <6fc9c5b7-a69e-48f7-9a88-d416bcc15791@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|PN3P287MB0354:EE_
X-MS-Office365-Filtering-Correlation-Id: 68b058eb-6ad0-45c9-691a-08dcd06673eb
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|19110799003|5072599009|8060799006|8022599003|15080799006|461199028|1602099012|4302099013|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	jrasYkjBdX39CibHSftUQZF44M5+mMCMcD7UM7ydTOnzOi0DqFD0XQh4ZyylHHi/wBQvZkHC/fYz1rIuOhx5Mgx3Tu6ysxBcuHQwAs+KRqRpV6yvEcFhoQovmQSUiYgQ9vOUmW+Lrxa5sbTHbToSzUxkzykIM+CrMvCUeQYwL8VULSSFkouBEYhRbBmGxblypUo6dNfAUfhrBPfAIK3nG73/HJJK+zTuzejDBrdV0VMYrF1/fyWynxSfpBdymIcgyZAKEHWRDkomTQL0D9gmpH73pE43Yv0lQdgkkvCAYxo2DklK2OzfAkixdgrqdOYs/yc1Fm2B6Lc7405Dpj0jtKdFJ6qcEptY6sftg6vkzJY56Q07RWNJCH8ceH9PVqN4FxkRK9OTgLryyCGjbX0V03Fp5w66qwQl2doV999uPCYVvM/L9ErgkcS1X3AaYjvdSJX880FyLX649W8lIJhENsEqA485a9FXHeLzn5w2z6fBApy3Q3z3Oas7rsXuwu1yXtht3gNU2lyvft12B7s4ZwjemTJfhWnsGSLQpl53LB7SdRXkuV2GXC6h6fOvqXIpCCqb9SNl2VDNfKnKjvUwEYlZN5H8DLCr7LGlkz5f4LxGdAtUZ55Pn+/MyocktTcBVO/9ErJ5M2OmVLztLrk7I7qKgq56L6gDHLETpV6TvGdpDZ9JK4RvkK6MSCgJngFpotDuAXjArirTvKZuTyLUwvleVtcqtKz6gbTmSlLt9qcIqxKN1bSxlTxpFxddnrHyK2Ag2es3vxEdMmbG8bRZTOh2y/5LXg0M6fKOSmArEynrJuaKM4x8DTncSP2Qk+IDLjqaclh+NibRhzpnwLbOWT1CORlDA810MxyLqBX8hxdBAoqq2ta0ZEZkF/d1FPR4
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NlNJbmtNMEgxcGwveVJ3RElUREtFZHpxTWNTcm9OYWQwSElVVzE1UjVvbUY2?=
 =?utf-8?B?ZVk4TTJLbWhIbnF3eERCSjBHemhhTmNFQjZGdVhiTFNkRDkrV1BLNEJTV0E3?=
 =?utf-8?B?WDhza1lIQXQvazVCTGpLMFU3NEVUYzRvblNMdENNTkUyTXMxKzRMN2hqeUY0?=
 =?utf-8?B?a2EvczlsZmNma1AwWDZvSVBvOVY3OVJZYVFZcTdWREIrTW4zNlZrVjY5YkNp?=
 =?utf-8?B?czFlbllNWCs2MkNZRGY4UzNZZ2FjR0hJdUhSOTZvR3M2Y1VEVkNsTGg4TFJx?=
 =?utf-8?B?b1ZiQXRZcFdPRE9oaDFLbzhUVFhVVTRnY2VEMkRoSlZ6Y1BBMlc2WmFJTlBE?=
 =?utf-8?B?b0N1M1F6TmJ6L0VYNmdJeUxrcnBBQzNKck9jbEFwVTVET3VuTlE2dHFERE1i?=
 =?utf-8?B?dG1OWnIyMkpBTGFjcmRHNXVLR0YwQ3NSbjdMdVRJZHBuMkRTMlVDazVNaGgy?=
 =?utf-8?B?WXRja0FZVDRxUnhjckdaQlZJbHhVcDlFd1F2MkNUS29iMXdoVzFLWjcrNHd3?=
 =?utf-8?B?MVloVHkzay9uOCtaY2tNVkVMLzFXYVg3bDVaOTJoRlpLYStObkpCYXNWdEFj?=
 =?utf-8?B?VG9OL05KMktJckdOSWxXTjFKY0NMUDIvb1M0MjZRNEJ0d1hZZ0FwL2lOL3pa?=
 =?utf-8?B?V2lXcm14VTNYUzE1VXY0VXNsQnU2ekVwSHRsbFd3bmxwR0tiZUZCZm5vTHZt?=
 =?utf-8?B?QkNjOE1EQjRtdHBld3hwU2RjUENVVUc4UFJDbUJ0UnIxZXpobFppS1JNajl5?=
 =?utf-8?B?R3NubkpDenlFT05aUGpzc2U1enpOS2VNdThSSERnY1JsdmhFTXR4WkNUS3Bu?=
 =?utf-8?B?ZmloZ2tIRnFmWVZFdWhpSVMyaDJNSDJtcnRvMy8vUFl5d29DZXFLL3BDTnNI?=
 =?utf-8?B?Nmx5a2dFWGg4bW9CVENNcTVvNkJ4UHprUzhrWkVrelg5MzJiWUpxSHlFbUh1?=
 =?utf-8?B?QWQ0dWd3eGw1azM4QjdSeDFleUQwM1gram50SjE3L3hRUnVsQjM4S2lTR056?=
 =?utf-8?B?UW5DUUR4dUJPRXdyODNLUnY3MUJ3ZVpxczlFNjJ1S0lwOUQ5RTVrSlU3b3hW?=
 =?utf-8?B?S0xkMlVVUjNieTJiVG8wTGxoQnc5Smh6aFBJa0hjaktUU3VISkJFcXZVR1Jq?=
 =?utf-8?B?MjVWUmJPUHc2Y2RhTnhRU09PRkZvYmpPeTBZekY0MUY0M1I1R2JSRTU0bkNJ?=
 =?utf-8?B?MVUxdm1mOHpyZHZqaDhjcHpqZUpicEZic09WcDlEQXc1aTA0bkk1Mk4zM2NE?=
 =?utf-8?B?ZTVjN051OHpnU00vKzJSSzFtSkZYNHVpK3JmVXF1OUxsNTZMem5Za1BUalNW?=
 =?utf-8?B?NFMvQk83UHUzdlFQZjBiS2pUblJ6WExRbGVFMldSc2JZcTlTL05mY2w5bXVm?=
 =?utf-8?B?cS9rOHYvSjlUR0grK3ByTHQydHJ5VlM4MWRVSytJc0NBRUVBdE43dVFCVlZi?=
 =?utf-8?B?bW4veXVXNWg5SVczUWZsZnljMHJTLzNtYUdaOHdjL2Fnc2x0Q243TStRNmx4?=
 =?utf-8?B?Y3RIQWxyaXZjVzdjWENuZUs5SFg3TDN2Y1l3TXp5MEplWEVpL08ycExFdEI2?=
 =?utf-8?B?UHdhOGRoNG9BNi94UHlsNy9sVDFzbnNodXdxblBmTHBhdXNvb1FFNzAzL096?=
 =?utf-8?B?czlhTktraTZhYjBXTFR6WUl4V3Rxem5ka2o1cHhnQ1MxaHI0bkd2L1JZa1NS?=
 =?utf-8?Q?+/NewZ4M9Kl5PCM2x1dz?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68b058eb-6ad0-45c9-691a-08dcd06673eb
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 00:29:24.7576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3P287MB0354


On 2024/9/6 10:44, Yixun Lan wrote:
> On 20:10 Thu 05 Sep     , Chen Wang wrote:
>> From: Chen Wang <unicorn_wang@outlook.com>
>>
>> Add binding document for sophgo,sg2042-pwm.
>>
>> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
>> ---
>>   .../bindings/pwm/sophgo,sg2042-pwm.yaml       | 52 +++++++++++++++++++
>>   1 file changed, 52 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml b/Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml
>> new file mode 100644
>> index 000000000000..10212694dd41
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml
>> @@ -0,0 +1,52 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/pwm/sophgo,sg2042-pwm.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Sophgo SG2042 PWM controller
>> +
>> +maintainers:
>> +  - Chen Wang <unicorn_wang@outlook.com>
>> +
>> +description: |
> you can drop | here
Ack and thanks.
>> +  This controller contains 4 channels which can generate PWM waveforms.
>> +
>> +allOf:
>> +  - $ref: pwm.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    const: sophgo,sg2042-pwm
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  clock-names:
>> +    items:
>> +      - const: apb
>> +
>> +  "#pwm-cells":
> ..
>> +    # See pwm.yaml in this directory for a description of the cells format.
> I think you can drop this comment, since no useful information added
> also it's already refered to standard pwm.yaml
I add this comment just want to reminder.  Ok, anyway, it can be removed 
to make doc clear.
>> +    const: 2
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - clock-names
> also "#pwm-cells"?
I think it has been required in pwm.yaml, so no need to required it 
again here.
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    pwm@7f006000 {
>> +        compatible = "sophgo,sg2042-pwm";
>> +        reg = <0x7f006000 0x1000>;
>> +        #pwm-cells = <2>;
>> +        clocks = <&clock 67>;
>> +        clock-names = "apb";
>> +    };
>> -- 
>> 2.34.1
>>

