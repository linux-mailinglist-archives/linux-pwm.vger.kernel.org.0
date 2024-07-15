Return-Path: <linux-pwm+bounces-2813-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFCE931A92
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Jul 2024 20:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1924228309F
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Jul 2024 18:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75837D3E2;
	Mon, 15 Jul 2024 18:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bOddZf3h"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DA71C687
	for <linux-pwm@vger.kernel.org>; Mon, 15 Jul 2024 18:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721069749; cv=none; b=bJ7OktWT0z6f3xCLXl+B/YkrbpbEhEtNawbHyrM8zqzi4xW4nU758dcPg/GWaHx4wfI2g/4JdUpTcHsF7qj/GqfPOofj09EaoqhAXe/YY7t/SRGo6iDMBEfkW9vslpm37lDtStoUlSnwwyEV+D6ejUv5QyWyISrclO+jF5ZPqHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721069749; c=relaxed/simple;
	bh=VRLigejefKy3+M3v99J/V2oxsp/Rduz0VyNCCzptSZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PFmNr6CyILraHhVfFihR3XONKuy0GHYj9vYeZfOR2ZChT3mdWt7dp1RHEAeGCV3o3Em3jdZgZQYtwOFm7h5Y3jE1iE113Urffoo4zBu371wcvAsd5MqR7KvSEpCXI3wfJWITkuOr4utDMIsO0yuUnIhLefPwiUDC08OIintyqY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=bOddZf3h; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3d9e233873aso2258022b6e.1
        for <linux-pwm@vger.kernel.org>; Mon, 15 Jul 2024 11:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721069745; x=1721674545; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x6Af9hE9HaFthYvE2ZX2b7ID1JatjiWTURLQiJieBJA=;
        b=bOddZf3hBpvcGCz68ein/drp+ghB/ZYtuokWYNqsF8HZqSJWp5rYYkYEmL8TeS3Ire
         rqqJjOs0H5Qm3KGMb4ohKrjoFOKB6Sdm1N9SREmlnywEDHfFxWEfgx7Ifzwxqg0mv5+E
         gq+mFAhysEnc5W1A348STuAm22ECO/4fvOp/GHC4MHDAdmA1PP7rG+KDbRwhNOuLmrRJ
         c1BmzBW0skvT53uy8lZ3eva6fJA0DpGKW5TBumCGjeSN4hdQ/TOa0SruSfyK50vmp8oi
         Llmahcat9QiEZ45tFROM+xFVggLgt8TNeOwpldFxMgh1JB4yNEE8AoDiuN/rnaoCmm+B
         CZ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721069745; x=1721674545;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x6Af9hE9HaFthYvE2ZX2b7ID1JatjiWTURLQiJieBJA=;
        b=tDFRmgGshvJFTC+76D4hIHjA++5JNXh5zfdLlPtQDrE7XqxhO+8ehES1FCH1Jz9SUj
         iliwzn7hwpvfBT2slxYG90Q0zqzMmXEYSWzvZt6PPm9XL0tH9kYrYap7zzR2vhMzPeq5
         Bzdgm7NRfyyEuE2vDS25geerbo07OahyCv/ybgTDGbEeooEJvgNDTVo7fqGpupqG18vU
         ebTOUKOtrO9gXr9QHqt+zBottTHTumzDY/dHTlAPSguz0jn8wsTQaxe5vmzyz3GhI6gu
         rGpYyTprMpQz4WXsIGugvkXobkE4tjcN3qInX04lV8nreLlfyNIl8/gzpaE8aVCtKQW8
         jTxQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3OBbrAaYUKh6eo1VknLNwf2/FFJJ9kUaWShEI6PeD/sdqswVlze9UZqSRhIiIjam72/AOakJAg1tu2Om3hEbVJhyBh+LdVFwY
X-Gm-Message-State: AOJu0Yz5puUPAoh70ZTRI08XN8lLVsa0xYz8cArm57Dx4YIiIi9T47Yq
	xEv0B/urkTrOr+7vb/kV20ar5oOnfkheiL+JwNImpLJIYVmQCaLqN+vj1QY1tGM=
X-Google-Smtp-Source: AGHT+IEWRGFiiw1w3+CcUh7gyGO3qKCI9vWiXNYBMa8QJt8pKvx735a6LYiVvc+O5or7bpj5xluWRg==
X-Received: by 2002:a05:6808:180e:b0:3da:a8f1:fe05 with SMTP id 5614622812f47-3dac7c2f2f2mr16191b6e.43.1721069745174;
        Mon, 15 Jul 2024 11:55:45 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3dab3dd22absm857809b6e.16.2024.07.15.11.55.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 11:55:44 -0700 (PDT)
Message-ID: <0b267668-a02f-4052-8075-d7134c9f8242@baylibre.com>
Date: Mon, 15 Jul 2024 13:55:43 -0500
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/8] pwm: New abstraction for PWM waveforms
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 linux-pwm@vger.kernel.org
Cc: Trevor Gamblin <tgamblin@baylibre.com>
References: <cover.1721040875.git.u.kleine-koenig@baylibre.com>
 <a4bdcfd66bc40fd245f521b89797993eba993afe.1721040875.git.u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <a4bdcfd66bc40fd245f521b89797993eba993afe.1721040875.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/15/24 6:16 AM, Uwe Kleine-König wrote:


> @@ -213,18 +311,60 @@ static int __pwm_apply(struct pwm_device *pwm, const struct pwm_state *state)
>  	    state->usage_power == pwm->state.usage_power)
>  		return 0;
>  
> -	err = chip->ops->apply(chip, pwm, state);
> -	trace_pwm_apply(pwm, state, err);
> -	if (err)
> -		return err;
> +	if (ops->write_waveform) {
> +		struct pwm_waveform wf;
> +		char wfhw[WFHWSIZE];
>  
> -	pwm->state = *state;
> +		BUG_ON(WFHWSIZE < ops->sizeof_wfhw);

Since this is already validated in pwm_ops_check(), do we really need the
BUG_ON() check?


> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> index 464054a45e57..2a1f1f25a56c 100644
> --- a/include/linux/pwm.h
> +++ b/include/linux/pwm.h
> @@ -49,6 +49,30 @@ enum {
>  	PWMF_EXPORTED = 1,
>  };
>  
> +/*
> + * struct pwm_waveform - description of a PWM waveform
> + * @period_length: PWM period
> + * @duty_length: PWM duty cycle
> + * @duty_offset: offset of the rising edge from the period's start
> + *
> + * This is a representation of a PWM waveform alternative to struct pwm_state
> + * below. It's more expressive than struct pwm_state as it contains a
> + * duty_offset and so can represent offsets other than $period - $duty_cycle
> + * which is done using .polarity = PWM_POLARITY_INVERSED. Note there is no
> + * explicit bool for enabled. A "disabled" PWM is represented by .period = 0.
> + *
> + * Note that the behaviour of a "disabled" PWM is undefined. Depending on the
> + * hardware's capabilities it might drive the active or inactive level, go
> + * high-z or even continue to toggle.
> + *
> + * The unit for all three members is nanoseconds.
> + */
> +struct pwm_waveform {
> +	u64 period_length;
> +	u64 duty_length;
> +	u64 duty_offset;
> +};

Perhaps it would be helpful to take a hint from the IIO subsystem
and include the units of measurement in the field names here?
For example, period_length_ns or even just period_ns. This way,
the value is obvious even without reading the documentation.


