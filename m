Return-Path: <linux-pwm+bounces-1685-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A57B486FEC0
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Mar 2024 11:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31EB11F20F32
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Mar 2024 10:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C499238392;
	Mon,  4 Mar 2024 10:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HYH/d3qJ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2064C38DE6
	for <linux-pwm@vger.kernel.org>; Mon,  4 Mar 2024 10:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709547304; cv=none; b=B/MxFiVKhHKElMu9y1FFlpH6/O9m8d137P2JEspHeTfcfbNQ/B2W14QvRcEkl8O+NuoQbZ9/adVbR75lDg6uNBuVs+7yrVszalPtS6ZQvwvOyIbDx+9DZz6aPeiR0pCKqjsETkKSrboNUZtHWqWDsnjphaIUGps6WO42jR1vCd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709547304; c=relaxed/simple;
	bh=nHNJeYfNBNJ9xMiXxh9TILtxSXYM7rX6QpJzZOkDurw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cFJyT5EuyAUULbsHJ/t0Kyx5J6Zov2wqeqcEneEYl1xcuDcUObIzayxin6JMDsTsHXvOt2GpxefiLVUCCGW1iR6Myi7yMczGSiJP5rE1up/mKGgJfcZVNb+mEDsVPlIJOSlCzsKNlxYaWa2RlPscRl3if+zs+VsfjrLwhDEA52s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HYH/d3qJ; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d094bc2244so61428041fa.1
        for <linux-pwm@vger.kernel.org>; Mon, 04 Mar 2024 02:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709547301; x=1710152101; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+N71wqWv249drMinLaztWYu6UMc95KoKU+EZgTsHKk0=;
        b=HYH/d3qJIR9onHKxiZ1ivbb9SHAdxX447vgcN20WEC58c8vGhSD+bjgR174+yWN/I8
         s++ZPJ8A1gdNEoDdblS+n48QHilOBgYkmp0QAI+FiW6PnL2z2w4qcnFdLjOApB6iysid
         zE0KmoM/T2dtdUeP993kSafjUDkF0p0sVDvS+MhZdKH0fRe7Ozin6sxmz7XHdm8RTQ2G
         rgN1JITulz9rSNSIQq1BdPDdMMaUd1QTV9QHR3eP5gO5PnMc770ejHnMaPkWhH5eLCVV
         ILO0CWUKVq4gOcw1iieWLVpRz+9Dhi3wnYfX1IikBCn+sY1+MEOl+B9PB8446Af6xofC
         tlNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709547301; x=1710152101;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+N71wqWv249drMinLaztWYu6UMc95KoKU+EZgTsHKk0=;
        b=aLH6DrSUcRnbewwBVF1sYZRbDIF7k4AradH8ufo1RjLTqCEnByVs+9Mn36W/I8y1Bv
         tia474uw/1VwjJoHo9BQ3iY5iwjTREyhjjACBPYuZpX6ztw79HE+cw2htltplSuWuJVE
         ii3qraiXxaeeDQOQem80lABN+HDHtbJV0zJjM4dwofbYW5nxdsT/TgMEZyYJeBy4seJt
         qk6CxTH9goIpIN/m60tYj69sY2OSUIE4eSJMRmp2gWWfZXNGRMipfB8/dHVGg7Ugjhn/
         SkyznomFSodVDojW4kesYZFAT2BdNYIf9K6zTcEOUhUCBF/OPrdKjw9NvCfziEM2t7ST
         hevQ==
X-Gm-Message-State: AOJu0YwgaUzJFFkvyrHGqOVKP4KDGM6L0gO2AqElw0RxKreBNCgRbCuQ
	MsXF3+GX/mMZmgc1PveT8I157VuNBFVKmptpyYd3Bna/0nnoG3I0DMKdzlvA3DQ=
X-Google-Smtp-Source: AGHT+IEmoTQNpJhlBEFBymKenckHc6iWq7+ohBmEQ4KWeCjchXincRN5Zfuqt7tPfiRwwdGgxK92fQ==
X-Received: by 2002:a19:7512:0:b0:513:2de3:6274 with SMTP id y18-20020a197512000000b005132de36274mr4902251lfe.55.1709547301268;
        Mon, 04 Mar 2024 02:15:01 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id lf7-20020a170907174700b00a44d66a16efsm2527968ejc.2.2024.03.04.02.14.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 02:15:00 -0800 (PST)
Message-ID: <91f0a339-ac0e-49df-bd26-dbfe1485308f@linaro.org>
Date: Mon, 4 Mar 2024 11:14:58 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] pwm: sophgo: add pwm support for Sophgo CV1800 SoC
Content-Language: en-US
To: Jingbao Qiu <qiujingbao.dlmu@gmail.com>, u.kleine-koenig@pengutronix.de,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 dlan@gentoo.org, inochiama@outlook.com
References: <20240304085933.1246964-1-qiujingbao.dlmu@gmail.com>
 <20240304090248.1247215-1-qiujingbao.dlmu@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240304090248.1247215-1-qiujingbao.dlmu@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/03/2024 10:02, Jingbao Qiu wrote:
> Implement the PWM driver for CV1800.
> 
> Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>

...

> +
> +	ret = devm_add_action_or_reset(&pdev->dev, devm_clk_rate_exclusive_put,
> +				       priv->clk);
> +	if (ret) {
> +		clk_rate_exclusive_put(priv->clk);
> +		return ret;

Please test this path - you have double put.

Best regards,
Krzysztof


