Return-Path: <linux-pwm+bounces-2128-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5B08B5155
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Apr 2024 08:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87414B220CB
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Apr 2024 06:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361F4D53C;
	Mon, 29 Apr 2024 06:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kimMguBp"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B505107B6
	for <linux-pwm@vger.kernel.org>; Mon, 29 Apr 2024 06:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714371805; cv=none; b=jEkzignmAuIUPz23Qfv7qwIGFz+LALk1gA/plV0LmUnIsiBbeFtJIeX8d5qct3ejjnWRrvy/Ylnuy7+L7mC8MjLMzJ0KqW7aXyFFMQQTEu0s0VnRG85PRK5fdRQrmRafSblfJz8nPQY2jQliPzHEUMV0EGA4zzisO+TAXYCBQAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714371805; c=relaxed/simple;
	bh=P4/qDR19PsgmjgwVzO4nY4WbE6N76lYUhAcE6LNIg5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qv0J9LqKA06O+BU207NF3PXZAE/Kp2J8/3JT3gBsmxncnNkqT7n4bzyTHB8CoXAbsWGgerFe1AiR6uVJA3UcOnsznQgGRoRpf65LxlNI+ljUacR0lSb01qe3Bldv/DqecxKmhGxKjH628Hku9c0f9YWLHYrnsNGABGBtuduFDpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kimMguBp; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56e48d0a632so6193441a12.2
        for <linux-pwm@vger.kernel.org>; Sun, 28 Apr 2024 23:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714371802; x=1714976602; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MS1IOFLM3PzwFKTmd7twEmxyXDBf0DKSlwhKzu4aCjc=;
        b=kimMguBpfQVrVklncyO9yYAL7vhN6uC2CJiQIRiKBVoFrQ20ohJzeH7/3mtDQiRuhS
         Cr6c07L/yLzSnici+PfOMRrbkAxCr0Pb8dWjUBlbiByWSyTcg2TIzsNTmi+yteDTc1LL
         ylhyMq2TKDYRU/S+U+10NESO2Uy6u0C+Icq63e1zWP8mExTggi+d51zy9gQDB9LriLBe
         Q8PYxJuH1h+aW+tuttRPxOYBXa3cVOFa1cZXvRx/kLxqnVmJDPavRV983VTjWw4Zvybs
         gKSgWsv8Qk8YX+lUg3ume2cJWC8hJdXRcZjPxq0mtZnRsBwmc/gjCgzWFmpaCVcLa0jm
         TtkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714371802; x=1714976602;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MS1IOFLM3PzwFKTmd7twEmxyXDBf0DKSlwhKzu4aCjc=;
        b=Idg80VpQJYlAvCVSjiO7M4JAUxLCwHtITSWx5xDC5ru2i7FZ9ciWfB92hWPi9T/5X8
         sOvsUfbw+ulzOU89x1/eIZId2VPLYP1YYByMWCdgZN4Dihah/bpzHWnqWwcd5sM5dnhi
         9BgnKNXoDbEfeVKwQ2adtCgOBA1nmf4HjzRs6g0kYTryR+KTNwF8DzMeWmd0uvuIhqpy
         pUOFXKmKUOhf6xrbADEELXU2oZkK8WbM/53tevQTDCW7or2Gu5OmG/KfRS87lUQBb7rB
         uu+bvaVqzghNtR7JnIW4EB4bFro15fKZS3Eq72ekUNTXuJMTDNkVNLiwyak3kQobWd69
         tumQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvO4NkQ3GL9exMb+hrPv2YQaH6loGudKvO4bVqojS7lEe9wqcL1FxlW9gw5eLl9pmX9hmM08Oj8XIeClfTFwLZLl2jQZShTZTL
X-Gm-Message-State: AOJu0Yz9Z6i+zEMQ67RJVJn9tt1801JXn8PIXuJtVkI0U6fkg7p6K4bE
	xTd6JbZrUbzdVVObldqGJE9aBG7cViPgXkjgSUv5Sihw0cnbVunyI1h0TUsfRRo=
X-Google-Smtp-Source: AGHT+IGiE/mnakLTudV4cBV3vN4R9lQP0MM87Qo4KhsBQM8MOky87K3EAsvfKKm1xIjWN6EjJiKCaw==
X-Received: by 2002:a50:d75a:0:b0:56b:cecb:a4c8 with SMTP id i26-20020a50d75a000000b0056bcecba4c8mr9028651edj.39.1714371802067;
        Sun, 28 Apr 2024 23:23:22 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id h4-20020a0564020e0400b00571f140e6b6sm9779434edh.97.2024.04.28.23.23.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Apr 2024 23:23:21 -0700 (PDT)
Message-ID: <148f8e69-ad44-40f8-b277-69c289b94c68@linaro.org>
Date: Mon, 29 Apr 2024 08:23:19 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2 v5] dt-bindings: pwm: Add AXI PWM generator
To: Trevor Gamblin <tgamblin@baylibre.com>, linux-pwm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, u.kleine-koenig@pengutronix.de,
 michael.hennerich@analog.com, nuno.sa@analog.com, dlechner@baylibre.com,
 devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org
References: <20240424125850.4189116-1-tgamblin@baylibre.com>
 <20240424125850.4189116-2-tgamblin@baylibre.com>
 <8bc13253-db16-4801-9f69-b06ba4e129be@baylibre.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <8bc13253-db16-4801-9f69-b06ba4e129be@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/04/2024 22:11, Trevor Gamblin wrote:
> 
> On 2024-04-24 8:58 a.m., Trevor Gamblin wrote:
>> From: Drew Fustini <dfustini@baylibre.com>
>>
>> Add Analog Devices AXI PWM generator.
>>
>> Link: https://wiki.analog.com/resources/fpga/docs/axi_pwm_gen
>> Signed-off-by: Drew Fustini <dfustini@baylibre.com>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Co-developed-by: Trevor Gamblin <tgamblin@baylibre.com>
>> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
> Note that I missed the following two acks from the v4 series when 
> preparing v5:
> 
> Acked-by: Michael Hennerich<michael.hennerich@analog.com>
> Acked-by: Nuno Sa<nuno.sa@analog.com>

You cannot add other people's tags that way. By default b4 ignores it.
Also, don't modify the tags...

Best regards,
Krzysztof


