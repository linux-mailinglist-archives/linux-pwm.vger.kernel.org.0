Return-Path: <linux-pwm+bounces-3153-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73828970AD6
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Sep 2024 02:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 010A31F21669
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Sep 2024 00:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C6CAD2D;
	Mon,  9 Sep 2024 00:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="I+ux4opw"
X-Original-To: linux-pwm@vger.kernel.org
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2027.outbound.protection.outlook.com [40.92.103.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D23F4C8D;
	Mon,  9 Sep 2024 00:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.103.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725842723; cv=fail; b=R4CnjE52WCiKDoeoQyW3hjLut6CFEr0m+QXh6Gu3nPrzs8fnnowkJEchnj2w2Q6yl9GcKjKWgDmRaavv9jz3kVAhCIqOXGqTvyS1ef3VH9d5XLqyFVfhmDrHspQKgfzmwqTs4JQxDFQQmVel3ny5ZwpO4I0GVTjfPbkRC7zoXag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725842723; c=relaxed/simple;
	bh=+DPe5+mbADSnz1iqKPH14J19Rqp4ZUJB4RRpmipPfEs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=URV5PgUpKtrl899Ieab+YTeMQx6RAoBYiUCIVaSG10sZV5z1qfW1EJPhhrL7nXpQrmu/OqKQ36yWr0nAUyBMgfAV9KlHj56BjpYY9CcQdvlEj3aqeh/QmUk1jLR661VTdQF9VuCkFM5S2Cf2diEyq4UspWgWv1UGN7nvr9olzMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=I+ux4opw; arc=fail smtp.client-ip=40.92.103.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tOJu31gcoR3QDB+9Nz3Y1yYVg/SxCfwR0b3uB91hOPcTMc4Gg4cZuOJPTA4Xh6zBqJdhswwH5PAVUbi6YVxh0azKCwXG6A/HGlmel3smG1Wqu0adlpg6wppiu475zdHBPGRbxWqpXatD/8yBw82ytX7KDgIIWeL89ATM7bPn4CM0ygXXEEI1zZYjOG1l+YA090H3l3gsqx46C7bvb5VGpHMB5yyYfyqTpqEAsq4seLTEuO6koTT3Tm6OtkWVVTcD7eLK8ISPDpaDC1Ok6JRGRZQRMI+Xaz+TCSq9sXUnvwdTJGvBFzMvPiJ7Kh07wC3wqvACMJPq5eg+5PNysabxCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vzrsSpjTbMITQ+WG9Mk3Yh/o8s/ex1WGywDnClXjzKI=;
 b=UIY4cj8e2l9MCc8WK4E/ANgQKk9cLLmFGWiAZyAz1xsA8fUikHsB9XalMR2Lj8KYnjly3pY4UKzqAsAOYGJvHaR4GucH1b+S6Q5WTjcrLmq85KJ4zsLmjRFXm2TBsIWikjwZ9hG0FPcRir51+e2yO3RcsZEixn6UzpSU53aSNbUMb1yKnjxrP40NUL/haH6idNm2Cz8Ah7xARinPv5tJ/MwkYcanvSkZ4VVRf2dlaAVRQEQqYfsrQz3KBuZaNwzWALg3EnH8rq1lUXiTBFOYlHL9/Phqd2N5vesb/jsRF2w1C77oIXJPuBk4jJu3mrZjCApUUPLwQmU/v8a4pbDeIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vzrsSpjTbMITQ+WG9Mk3Yh/o8s/ex1WGywDnClXjzKI=;
 b=I+ux4opw3SlAXtnmLcFemy1G8Q3YNWtf5RdhWtX6OZsr1rXpWj2W/oSzmDKMvwbeQfYSk9P5FWZVyOCirxFKFs7e17x1/aEY5zudtgY7m4UJN/m3OcP8W1lYguq55aZMDivyQcqaYfg5MMtx3REA9KISAAAC0R34z1+QDXZCbyd69WyABZjlloKeph4faGnRQhT0Yph57QCXOPOaalbtZ70jMEhpQrQEmV6JX/bTY11gnIdnQBOpBkK0r/dFfRSxYJx2meJxH31nVaTqw2ZQT+l5JszoVhUFV3SHiYV5dQXgL9BRpuPPcNs5ese/wrh6fo0mbPQFLUD9xTdf1MEcOw==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by MA0P287MB0916.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:e0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Mon, 9 Sep
 2024 00:45:14 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c%4]) with mapi id 15.20.7939.022; Mon, 9 Sep 2024
 00:45:14 +0000
Message-ID:
 <MA0P287MB28222BA933FA505DDAC89CEBFE992@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Mon, 9 Sep 2024 08:45:09 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: pwm: sophgo: add bindings for sg2042
To: Krzysztof Kozlowski <krzk@kernel.org>, Chen Wang <unicornxw@gmail.com>
Cc: ukleinek@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, inochiama@outlook.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-riscv@lists.infradead.org, chao.wei@sophgo.com,
 haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com, chunzhi.lin@sophgo.com
References: <cover.1725536870.git.unicorn_wang@outlook.com>
 <6e5fb37472b916cb9d9abfbe3bea702d8d0d9737.1725536870.git.unicorn_wang@outlook.com>
 <clq2dwmsks56553cythofgd3x5sw4t6pss7cxup2hrvj2n563g@3ishagojtabx>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <clq2dwmsks56553cythofgd3x5sw4t6pss7cxup2hrvj2n563g@3ishagojtabx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [eEI5scsklPZ1p9qOPj/U6wDOGRUh7rlH]
X-ClientProxiedBy: TYCP286CA0012.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::16) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <c1c15693-925b-451c-aa10-60df07d18467@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|MA0P287MB0916:EE_
X-MS-Office365-Filtering-Correlation-Id: 99743621-d3e0-4eb1-a0e3-08dcd068aac0
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|461199028|6090799003|5072599009|19110799003|8060799006|3412199025|440099028|4302099013|1602099012;
X-Microsoft-Antispam-Message-Info:
	lKntOInxYLx2HCLzTXKuayj5jI/iU3eFwcqkTrUotiJXPFocOjKfS8tx+N7RwsdPgrXKv+VeJisndqrxxwSso4ZCkoouBEacI1pEvZvuF8Jyf9dQbbXjvsPSpMjnj0E4tAZsA6ksmsIn2RzZJu4KN14bb6W23tl7XuXaDx2a4ppWqgyYUaCPR5zWOWJt/VpEb3QLhi1hA4vVXn+m+mR5b0dZ3QgC3P4E3iyZiW+U4M4q3QWKCHnYOaRr49BNbzsQ5vJHtLk5yOsNNdAu4F0rf3VrWWimTJUoavVHDOPGBbj7/kVwAvYLJhTIlJtkGwjI+goiT4Mn2Kqi3ggWeNH87v+DcOkeJ+LIXofJntDUsimw4sj6SjfewzyZFZQnTWJvMpiI5PQwCSikyZQn8BcqDFjcxJiuUvfguoQNPJu3Kqj9O8rq+9jtzmaT23VNC1L9L7scxFmx5HXP2V4ncutyVkyEn4WPUVSkXloUxYHTD2ilLYP1DazPjNzgmoMvqUYnGXdYGX7nLdkBFn/4q5/ra+7myUz5JHaI+cUU/AUOgiJp9/b/FvFa1ZEvyXViRPP84zDyd2f0/WbW0ZXdv1tJ9dQLXdDO/c09wVCExjNH1DqECGfpZjqLGzB3Fh7gMP03GJSIhbSVCOs/SYMc9WzHYHpI9gRCASHbD+1AbFQjbJMuZN3DcYtaxDw32HnubLnTSIuTwniZJMZ7QGKVqVQD0IJZN3lA/m1z9bVJb9dLnsOmZY/kNwb9R7nGCZpfAQG4//91OEcbCaxizZkeWm8kcFemfvEAAZw+W710vvitORTuHbrCXfswvuD/LZ8KkXAAswbbdOvxopB24S2lVt8sTTn4+kJO2V8onoIyd2lI5oo=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M1Npd09EcHBRYXV1cUtac3hjRmUvUXpwM000ZmxXeTJ3WUhURW8xaVYzakQv?=
 =?utf-8?B?djNnZStJTDBTOEdWNThMLzJwZHZienhpZFpsWnFvSXVuT1lLL0hoSHBFQ21J?=
 =?utf-8?B?Q0hvREtQYW5Vcm1PeW90cFQ1YW5rRUlQSkU4OC94STQ0cWZlZGs5eXZ4bWRm?=
 =?utf-8?B?WXJwTGZkdGVQSkhLbGxER1U1ZC9GRm5GbDNmazNURDJibzVnMWxkUjVlY0VW?=
 =?utf-8?B?a1h3Z0VaQ011RzJaRmtVS05mT2puamtCUFF5RWNSMHRmMjNFcFh5bEVKS1Fn?=
 =?utf-8?B?V01ycTlPMnJMTzdYWkZRbzVTNHJJVUF1WndBcjIvSm5jdHliU1R0M0ozY2dZ?=
 =?utf-8?B?MUU5S0xpS3U0MWpKYkpXczNLaUdzRTJ0TytXOGNJY2F1V2VSY1QwbWtjODl1?=
 =?utf-8?B?SmhkaXB6QmU0MFA5ZVk0TGcrWUtuek51N0tBMUxrdW9aZUpBSWNWWXp0WGZC?=
 =?utf-8?B?UWZUN0F4VlNldE8wMHNkc1hZOHNDODhBVGhEb3N1bGVZWUFyNlRxa2VPenVL?=
 =?utf-8?B?djVYZythN3VUSW50d09uUUhsNmc3QzJ3NjhjZ0JvalJSOS9sdkdRYVJJb0ZH?=
 =?utf-8?B?eGFVNE9tREZubnBpNE94NUQwM3Axai9sc0ZENHFac0lwcTNqODF4aHRHajdW?=
 =?utf-8?B?NExLVGtTV2dUUFlnc0crc0ZkbmxLRzYxUnBpQy93T1hDUlFpeCtTc2hHRUZm?=
 =?utf-8?B?bDRGUkdZcmM1VnV2aUg5V09NRE1WSFRCWFBOekNmd0hvdkNMdGp4bTV1NEVR?=
 =?utf-8?B?T09Fb1FlR0pibHBFOVlyRXVDUForR20wY1U5R3F5UWRQL2VlekxMazJVZVJz?=
 =?utf-8?B?d1IxQytHUkoxTXM5VS9lcUl5UENXODNNRlJoRUlTUlZYSDFVTEJLYTQ2bjNU?=
 =?utf-8?B?SW1mS3pnSm95TWpwOFlDU1RVajdSRTJkLzgrUlczSGtlU0hHQ0hOb1JuS3ow?=
 =?utf-8?B?Ry9mMHJXL3pPaDc1RTk5eTJ4L0loNEZZS1pQcDgzSHZIalFhQjFYWm8rV0JV?=
 =?utf-8?B?OEg4UHFJTU9JL3NoMUxQWmxMZ1pQdU03U0NzbWQ2U0xyK2JBcjNzZTBxTGUv?=
 =?utf-8?B?OE9ydVlXd3VVcmZhNEhTc2xteVViSFBTMXBOY0pkT25Zb3JacmUxZHBQaWJB?=
 =?utf-8?B?Zm41SU4vOFFZS1Nacmo5aFo3TGQ3eTNCZVg0RUlYMDRBWHEwTlFYVXpkTWRs?=
 =?utf-8?B?cUtPMEN0MVVPajVhcm40Ri9VZEh1UkVuLythT1IyVzY4aUU3M2Y1Z3dJWmIw?=
 =?utf-8?B?amVvZ0g2Y3NxcXBublNOVzZlY0xwd3J4emNZY1gvN1lMdnA0dy9vN2RhMkN3?=
 =?utf-8?B?TkxWOTJRYWRUcWp2TFlsVjVTcXloS01oVVNUUzZ0ZkgxZytqZUVla3dsdldq?=
 =?utf-8?B?aS82cVNqZWk0aVFWNXE4TTBWd0xEalN2OTdHdFMrc0NaWE5IVEV2NnhER3ph?=
 =?utf-8?B?M29KOEEwY0toRWhPN2NyRlA5U1UvRFpBVXdCcDE1S0Q3SERmS0IwQ2hVdW0z?=
 =?utf-8?B?T3JYZVplN3UveDBzSGJvT0I5NksvV2c0SG1ld1B5RE5Ob0NhTkJMamJKaTVr?=
 =?utf-8?B?RmJ3akgzbVdiY3NDRmFKTTV5clByNGMwcmlOSitDc0lQY29RR0pFUjBzeFJn?=
 =?utf-8?B?RmZtM1BOVEx0MHFiZERYZEI5YmRrVGwzWGRxZHRzREJVaUdZY2dRdGl2U0RC?=
 =?utf-8?Q?zEQpviX16NEWu5ez9zo6?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99743621-d3e0-4eb1-a0e3-08dcd068aac0
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 00:45:14.2324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB0916


On 2024/9/6 18:31, Krzysztof Kozlowski wrote:
> On Thu, Sep 05, 2024 at 08:10:25PM +0800, Chen Wang wrote:
>> From: Chen Wang <unicorn_wang@outlook.com>
>>
>> Add binding document for sophgo,sg2042-pwm.
> A nit, subject: drop second/last, redundant "bindings for". The
> "dt-bindings" prefix is already stating that these are bindings.
> See also:
> https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18
>
> Say something useful about hardware instead. The same in commit msg -
> you keep saying obvious and duplicated commit subject.
OK, thanks
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
> drop |
Ack and thansk.
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
>> +    # See pwm.yaml in this directory for a description of the cells format.
> Drop
Ack and thanks.
>> +    const: 2
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - clock-names
>> +
>> +additionalProperties: false
> unevaluatedProperties instead
Yes, my mistake, thanks.
> Best regards,
> Krzysztof
>

