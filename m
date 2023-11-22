Return-Path: <linux-pwm+bounces-143-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0647F499B
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Nov 2023 16:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C543D280F81
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Nov 2023 15:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC814EB47;
	Wed, 22 Nov 2023 15:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xSkQaPVM"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACAB41A8
	for <linux-pwm@vger.kernel.org>; Wed, 22 Nov 2023 07:04:21 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40907b82ab9so5512375e9.1
        for <linux-pwm@vger.kernel.org>; Wed, 22 Nov 2023 07:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700665460; x=1701270260; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jG5F2lZxOZlezgA3HC707U0424BNKOg62ncFOsTiPuk=;
        b=xSkQaPVMBTaZe/4N0r6rk+BpiK0f5bSbYQoQOcyodWJ7hghgkWXuPfagaU+jc9zmD4
         Vysk2wwPFqw7C8NVHxF5yt8FxWuZxc7P58wp8iAkhYRExcg37g32hFNZEA/HvHOVdToG
         pdrsZGWct8Y07e/2QicUQCuxEU3fakpl1SnRL0Zx0me7YcQ6LEnxWz4yQcFyspvX3N2o
         LDPpDpvxJpWdpKxdy8acWNT4fzQpBiwe62zFB9nTJPGG9YZcqj/F62zyFofvgN1mkE8+
         gIIN9OeFymvqzuoyJMCouf4aXpQqO5bZe5eHGo+XcoWIo+18llnj2dwMxJoCnwUBnFlo
         ukQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700665460; x=1701270260;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jG5F2lZxOZlezgA3HC707U0424BNKOg62ncFOsTiPuk=;
        b=QoNK3KxAv5m4VrwW7KB6/w00HUsXS5t/Exl4Qu8OqhDBKtIk/HxY8DGEjHp/yn98Gz
         1fWBbTb4Aon3Auh6FN2KiO+3Fv5sp9awRXt9MA7qbXDFOWQSXwxxElNUn72UHJimh4H7
         zqYLME8kkDZVUeW8YRusuvA3Z6Pto0g8Co0JNAgz3gs6QL2WDtgQeWkdnDTcljNpic8F
         uTUEm1HpzJI+qorTethY3FWiH6uGBTu8XzMSnQRzsjw/R9D8eJtLnhVT7PL+NjsuOuWJ
         MmW4dtDca7Od7abyJIr+SdLolWvLNsXzARxhUl9q9JvS0V+Ksr1BOii7OYEdlXuYMzWX
         471w==
X-Gm-Message-State: AOJu0YzXYRd8mtOcxUoliuZgYRi9tfWcujFyA+1PKMrpIGaRZ97XRBW4
	WRuCQWokkhIeH1WPqbbkBuz8dw==
X-Google-Smtp-Source: AGHT+IFh5RTGEGeuNu/qsH+i4IdfhSPVJa8teuEU1d9rNnvFoOqj2csdYCDL7q8FV+lnDcxOsUeC9A==
X-Received: by 2002:a05:6000:1843:b0:332:d1cc:b861 with SMTP id c3-20020a056000184300b00332d1ccb861mr2071211wri.25.1700665459932;
        Wed, 22 Nov 2023 07:04:19 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.100])
        by smtp.gmail.com with ESMTPSA id d16-20020adffbd0000000b003313902cef5sm17368513wrs.93.2023.11.22.07.04.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 07:04:19 -0800 (PST)
Message-ID: <2bbc2031-89d7-42e9-828e-068fa06eabf4@linaro.org>
Date: Wed, 22 Nov 2023 16:04:17 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] dt-bindings: pwm: amlogic: add new compatible for
 meson8 pwm type
Content-Language: en-US
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: neil.armstrong@linaro.org, Rob Herring <robh@kernel.org>,
 JunYi Zhao <junyi.zhao@amlogic.com>, devicetree@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Kevin Hilman <khilman@baylibre.com>,
 Thierry Reding <thierry.reding@gmail.com>, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20231117125919.1696980-1-jbrunet@baylibre.com>
 <20231117125919.1696980-3-jbrunet@baylibre.com>
 <170040994064.269288.960284011884896046.robh@kernel.org>
 <4608012c-059f-4d6a-914b-e85ad0c32ff0@linaro.org>
 <1j5y1wg3sb.fsf@starbuckisacylon.baylibre.com>
 <2e7a65da-5c1d-4dd4-ac69-7559a53afdf3@linaro.org>
 <1j1qckg21u.fsf@starbuckisacylon.baylibre.com>
 <94e69281-93e1-41cd-9cf5-81cbbc15572c@linaro.org>
 <1jwmu9et6j.fsf@starbuckisacylon.baylibre.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <1jwmu9et6j.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/11/2023 15:34, Jerome Brunet wrote:
> 
> On Wed 22 Nov 2023 at 09:37, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
>> On 20/11/2023 11:04, Jerome Brunet wrote:
>>>>>>>>    .../devicetree/bindings/pwm/pwm-amlogic.yaml  | 36 +++++++++++++++++--
>>>>>>>>    1 file changed, 34 insertions(+), 2 deletions(-)
>>>>>>>>
>>>>>>> Reviewed-by: Rob Herring <robh@kernel.org>
>>>>>>>
>>>>>>
>>>>>> I'm puzzled, isn't it recommended to have a per-soc compatible now ?
>>
>> Yes, it is.
>>
>>>>> I have specifically addressed this matter in the description,
>>>>> haven't I ? What good would it do in this case ?
>>
>> There is nothing about compatible naming in commit msg.
> 
> Krzysztof, the whole commit desciption is explanation about why a new
> compatible is introduced. I don't understand this comment.
> 
>>
>>>>
>>>> Yes you did but I was asked for the last year+ that all new compatible
>>>> should be soc specific (while imprecise, in our care soc family should be ok),
>>>> with a possible semi-generic callback with an IP version or a first soc
>>>> implementing the IP.
>>>>
>>>>> Plus the definition of a SoC is very vague. One could argue that
>>>>> the content of the list bellow are vaguely defined families. Should we
>>>>> add meson8b, gxl, gxm, sm1 ? ... or even the actual SoC reference ?
>>>>> This list gets huge for no reason.
>>>>
>>>> I think in our case soc family is reasonable since they share same silicon
>>>> design.
>>>>
>>>>> We know all existing PWM of this type are the same. We have been using
>>>>> them for years. It is not a new support we know nothing about.
>>>>>
>>>>>>
>>>>>> I thought something like:
>>>>>> - items:
>>>>>>      - enum:
>>>>>>          - amlogic,gxbb-pwm
>>>>>>          - amlogic,axg-pwm
>>>>>>          - amlogic,g12a-pwm
>>>>>>      - const: amlogic,pwm-v1
>>>>> I'm not sure I understand what you are suggesting here.
>>>>> Adding a "amlogic,pwm-v1" for the obsolete compatible ? No amlogic DT
>>>>> has that and I'm working to remove this type, so I don't get the point.
>>>>>
>>>>>>
>>>>>> should be preferred instead of a single amlogic,meson8-pwm-v2 ?
>>>>> This is named after the first SoC supporting the type.
>>>>> Naming it amlogic,pwm-v2 would feel weird with the s4 coming after.
>>>>> Plus the doc specifically advise against this type of names.
>>>>
>>>> The -v2 refers to a pure software/dt implementation versioning and not
>>>> an HW version, so I'm puzzled and I requires DT maintainers advice here.
>>>>
>>>> Yes meson8b is the first "known" platform, even if I'm pretty sure meson6 has
>>
>> Yes, this should be SoC-based compatible, unless you have clear
>> versioning scheme by SoC/IP block vendor. You named it not a HW version,
>> which kind of answers to the "unless" case - that's not hardware version.
>>
> 
> This is specifically the point of the comment in commit description.
> We know all the PWMs compatible are the same HW (version) as one found
> in the meson8b.
> 
> It is certain that adding more compatible, listing all the SoC, will be
> useless. I can do it if you insist.

The docs you references insist on that, so yeah, I insist as well.

> 
>>>
>>> This is not my point. I picked this name because I have to pick a
>>> specific device based one. Not because it is actually the first or
>>> not. I don't see a problem with meson6 being compatible with
>>> meson8-pwm-v2, if that ever comes along.
>>
>> No, the point is not to use "v2". Use SoC compatibles.
> 
> It is a SoC compatible. The second one.

"v2" is not the soc. I assume meson8 is one specific SoC, right? Because
elinux says it is a *family*:
https://elinux.org/Amlogic/SoCs


> 
> The first one, as explained in the description was describing the driver
> more that the HW.
> 
> Changing the way clock are passed from DT to the driver would be break
> user of the old compatible. So a new compatible is introduced. I believe
> this is recommended way to introduce incompatible binding changes.

The way is not to introduce incompatible changes. Your way is also not
good as it breaks other users of DTS.

> 
> v2 here denote a new interface version, nothing to do with HW
> versioning. I happy to pick something else to denote this.

Sorry, then it is not a SoC-based compatible.

> 
>>
>>>
>>> I think the binding here satisfy the rule that it should be specific,
>>> and the intent that goes with it:
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/writing-bindings.rst?h=v6.7-rc2#n42
>>>
>>>> the same pwm architecture, this is why "amlogic,pwm-v1" as fallback seems more
>>>> reasonable and s4 and later pwm could use the "amlogic,pwm-v2"
>>>> fallback.
>>>
>>> That is not how understand this:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/writing-bindings.rst?h=v6.7-rc2#n82
>>>
>>
>> Again, where the "v2" is defined? Where is any document explaining the
>> mapping between version blocks and SoC parts? Why do you list here only
>> major version? Blocks almost always have also minor (e.g. v2.0).
> 
> Again, v2 does has nothing to do with the HW. Never wrote it was.
> The HW remains the same.

Don't add compatibles which are not related to HW, but represent
software versioning. Software does not matter for the bindings.

That's a clear NAK.

Best regards,
Krzysztof


