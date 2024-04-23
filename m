Return-Path: <linux-pwm+bounces-2047-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6618ADF75
	for <lists+linux-pwm@lfdr.de>; Tue, 23 Apr 2024 10:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 509631C21733
	for <lists+linux-pwm@lfdr.de>; Tue, 23 Apr 2024 08:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2324EB24;
	Tue, 23 Apr 2024 08:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l+2uzccH"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1403345BF3
	for <linux-pwm@vger.kernel.org>; Tue, 23 Apr 2024 08:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713859726; cv=none; b=IhI3onSx5zsF2+A5spwRK8AnBTgc+0J2n4WbJLSUbUNH5w6zEKMqEZ7t7HmY2A7RbkEqQ2r33CjE1ORt6o51YynCMYBvWRpUPR0ZmIntgcWqcjkCZqmbBjlVwULylCZyv2ASqhvh1gYqBu0LfG6uxQTluqUGIQH0rOkFzH30f7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713859726; c=relaxed/simple;
	bh=wLa+Cj5GCg4x8jycojoEYo8ruFJA3ooYCYBk5tPbY3c=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=h61YeRfcOiXlf0eoE93LvveV5qiadTMoglDYKTMrzuNHmECj/80V17IgF9B8JISbda/LctuqhyrC3xOLh6bGUIj8zZMuoV9Z2RcytMdMThWMIEWJ2OJk1OulATvfE6MQKf0ZycvYxc2EIXzNuhFaeBj3PhW0MJX8gRcYD8agdd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l+2uzccH; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-41a1d2a7b81so12127565e9.0
        for <linux-pwm@vger.kernel.org>; Tue, 23 Apr 2024 01:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713859722; x=1714464522; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8/oC2VtzrpJJKpFX/zRYpL4IVC3DtVUzT3QlRoS7w7o=;
        b=l+2uzccHWvyCzKTTmk/JcPt1qpKajRQG8oiz6qHnbWfOwCo3nnMFd2/UIqxchXW61F
         UwRn+Em5ETHpJh46658eIaWzNtN8YVFbpdGol7/oJpGwB0jlpjAypeeMDVNIo6azekhX
         xzNoWcQ/8iexPxefHjuhVeVmnv1LCwrVmyvIGUdlP7R/rM1aKD9cGRZmCfaHs/QoVJIy
         JEWGAckrQ5r7sMBmMvWtQKfP3mnv4t5hPuWQvOyIBMrnG3L6JF32isSq8+6618dNkIlU
         2OkspDE2gCeV9KDWIe15d0qASh6gbB+74l7D4Xy0CLJygkkU+jh89gfGkmViIi1vzXpQ
         EgVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713859722; x=1714464522;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8/oC2VtzrpJJKpFX/zRYpL4IVC3DtVUzT3QlRoS7w7o=;
        b=vCZcJgn+knBENzsBKXaocjMe0mEEGtAvtcximNEej5btAFvO4ltUp9kx45COwrYctT
         vtCBFlVT3VoMK9YnrRpkeEdRPq02hnWG7agvg8ks/PkppN2pX72WaeMXS0E7odwBk4uj
         Qr423bGmFjpP3quGNeNstAXrpfQCqQG1YXnUf5LdddIzoZA25Drq+7qliu0mZTQ2x0Iv
         8dVFgExQ2sXH6pQHR6YoMqjDqnguR94QSxFYizOTWgMRC2O4srz0rU5z7s20t/7FLga5
         vRQAkySl4o3ZwEBHmh0uIAMTAjCYkuGBpJGRT6jPkqYy0LH1uK+5I3KaMBKnRPORNK2x
         dMow==
X-Forwarded-Encrypted: i=1; AJvYcCXGZr8TcjwGGT6xX1iJqxRMFZkjqJfR93vAiRtVK485uxA3iG3a3SUTp1vzKvdeD1/PtEwZ3L6cEuTvUEknqBDES6+lIiq3QAWe
X-Gm-Message-State: AOJu0YxzxMOHSt264BspStNbr8LL40mwKg2qfN/iyxL+KynJ2pdkK6vH
	xqWSe3vBwj/qwcEVE7x+S/mMAKvDomFt80OeULo7+CHY8ymuYiDkOhDqQc04aA8=
X-Google-Smtp-Source: AGHT+IGj3V51mN4o70u97cNRT3Eg+WA5oX7EwBLrwSwL4MS0vJPp5BQU4b374eoAEqNcBb+MC/ho4g==
X-Received: by 2002:adf:a151:0:b0:343:6c07:c816 with SMTP id r17-20020adfa151000000b003436c07c816mr1361089wrr.16.1713859722150;
        Tue, 23 Apr 2024 01:08:42 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:815e:851b:255f:e3ee? ([2a01:e0a:982:cbb0:815e:851b:255f:e3ee])
        by smtp.gmail.com with ESMTPSA id a16-20020a5d4d50000000b0034a9b75e272sm8664280wru.45.2024.04.23.01.08.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 01:08:41 -0700 (PDT)
Message-ID: <a2a2fa0e-2194-40db-85e7-d586c512231f@linaro.org>
Date: Tue, 23 Apr 2024 10:08:40 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v5 5/5] pwm: meson: add generic compatible for meson8 to
 sm1
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Jerome Brunet <jbrunet@baylibre.com>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org,
 JunYi Zhao <junyi.zhao@amlogic.com>
References: <20240221151154.26452-1-jbrunet@baylibre.com>
 <20240221151154.26452-6-jbrunet@baylibre.com>
 <24ec3iiudmfapiosygpsvgu7kmdqe6csbkpuzx3p3sa4oyodqu@hshmbpvzhufb>
 <1jplumc276.fsf@starbuckisacylon.baylibre.com>
 <4v5lhnjbfnjpj4k4rme6kfphurr56ae5ngup7pcsrxhs4f7qh5@jian42uepseu>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <4v5lhnjbfnjpj4k4rme6kfphurr56ae5ngup7pcsrxhs4f7qh5@jian42uepseu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 18/04/2024 18:08, Uwe Kleine-König wrote:
> On Thu, Apr 18, 2024 at 01:57:03PM +0200, Jerome Brunet wrote:
>> On Fri 12 Apr 2024 at 14:08, Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:
>>> b4 + git applied the patch just fine even without patch #4 of this
>>> series. Would you be so kind to double check it works as intended?
>>
>> It does, Thx.
> 
> Thank you.
>   
>>> BTW, b4 diagnosed:
>>>
>>> Checking attestation on all messages, may take a moment...
>>> ---
>>>    ✗ [PATCH v5 5/5] pwm: meson: add generic compatible for meson8 to sm1
>>>      + Link: https://lore.kernel.org/r/20240221151154.26452-6-jbrunet@baylibre.com
>>>      + Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>>>    ---
>>>    ✗ BADSIG: DKIM/baylibre-com.20230601.gappssmtp.com
>>>
>>> Is this only because it took me so long to reply, or is there a
>>> configuration issue with the baylibre MTA?
>>
>> I have no idea. This is the first time this is reported
> 
> I just picked up a patch by one of your colleagues and there the DKIM
> stuff was fine. I didn't debug that further.

Google's DKIM key gets rotated, after while the DKIM signature gets invalid.

The best is to add a GPG signature on top of DKIM, like with B4.

Neil

> 
> Best regards
> Uwe
> 


