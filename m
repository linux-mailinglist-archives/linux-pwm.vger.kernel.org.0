Return-Path: <linux-pwm+bounces-3792-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2629AD95F
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Oct 2024 03:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 301C4282757
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Oct 2024 01:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5469642070;
	Thu, 24 Oct 2024 01:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzfImWMm"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDAA2C9A;
	Thu, 24 Oct 2024 01:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729734220; cv=none; b=e/xiG0N/Cu8GU/rWERKqZUpOS1THXvrz0ham6csdJC+rZ9hYdVTzZJkiCoEFWPMY1vEqX+5T/8utlINZOGcvrEhRcongJ5B+JIvV7FbMH7b5Wkz4adb3sN7Y9B8WfVxxrskiHkxLVjg70IcbI7s+PSNJNyn11S4sECyFy75VU5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729734220; c=relaxed/simple;
	bh=uiJxTc/Px6OxDE7VwWmByvD/Jg1LJ6kQk2LZwhNTe48=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tgbBjfxx96cWUtHcYKsWAJfVqybHaCf5trm4KpjwFpFwUvvt8XkJ6nv/Ve4myPufUX41qyh+JPkxuctUwFZw5m8ePTYc3Nzu65xzXZ6G+V2y1Z3CBPUfKAbHLsd7x3iVxqJZR3ED2rW72FmiodKtThao+0zGcxGmaBnDYUi7JGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kzfImWMm; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7edb3f93369so23904a12.1;
        Wed, 23 Oct 2024 18:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729734218; x=1730339018; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uiJxTc/Px6OxDE7VwWmByvD/Jg1LJ6kQk2LZwhNTe48=;
        b=kzfImWMmBQuaI//XrtsLiGrteUhPht0T2xTHDtdqXgSfYFuQTo4wVxlxSh3DnAg+M1
         b0VVrXAJ7T/pWRIQHTuZuv8a52A1yFJYYPZ0KgTIuvv8SRNqfr5Eqq5CAdnO6ibUDUhF
         k1NEy0Zri/3h7jsLfQZWMKHvPP+kq9nlrkZdRlzO7Z3h4BzcqoCxUjo/Q5wrEIoiGZVD
         idYtzSK3G7FZuIV8oMi+W9s1jAO1pUfTi4A/sGdPQC/ojbrV74X2suycSH9myD62PPbq
         54xQo8jamP/TWwqNmChEXK7LeQLc8tb3QB4tLWRuNHf/6w87PVFX8pnYikfDqMU0KBFC
         oL2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729734218; x=1730339018;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uiJxTc/Px6OxDE7VwWmByvD/Jg1LJ6kQk2LZwhNTe48=;
        b=SyZxtm8F/GEM+O7zGBPGqPDrIt9eJXZ45Z4TDb3t09Ht9vDjXr3TYZ0wWhqz2n5U6E
         yF+H1OmhTvsezhEBD1IIPJDzhJqCcBnzS5pglub+8wdD7C7+1IM5Ls25kAYDTNi4+7Z6
         EqHmpvlubD3qcsRGVCdL+V5DwLNDRmuIs3JCmWM3pH4HuXVPuSuT5wzAjXYkUDc28g8p
         Ps2pC3GOoTyNjcXAUyc58WFmtJoJ6FQX49IchDJQ0ygbZ1RvdAkrEPpIQoR7MmkyPX+M
         F/kBdVHqv1bhedLi1cEodz5rHj1wg+uDBpwfS5UgGA1eKFT2DLTQuSPgogkdCJCiBiKy
         OJUw==
X-Forwarded-Encrypted: i=1; AJvYcCXRIHIvky5J0TsSfbxXuO5MumiK+QGFbS8ySdBBxrW+ayqeEZK73LpcIbcblHPKKbs3qwYmnldK1ENH@vger.kernel.org, AJvYcCXSgffKBFCPKMTGbZVNAAi14nnMkrahUx96MhTCgNW5aLAPGGqRLvpNLFsjgpNbsspH5M9FDe4zREpp@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+hAaqgZ1K86+BINcIjuX0XjX7oTV2r6NIdtJXE9NXtsQWzP/Y
	evsi5+eY/gNyen0yb+2qS+sMRSpNFlpJ8A4Tg0CgJRq7yLVu75U5
X-Google-Smtp-Source: AGHT+IF5IFwQmeo36Myq+rqWB1r2VH+1fK3KEPPTGP8CBe2t6JWt7y/eFWA1OKHXVbzhnx+sn2bUzw==
X-Received: by 2002:a05:6a21:2d8b:b0:1d9:3957:8c24 with SMTP id adf61e73a8af0-1d978b39ee6mr4657695637.21.1729734217802;
        Wed, 23 Oct 2024 18:43:37 -0700 (PDT)
Received: from [172.19.1.42] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec1407f55sm6950187b3a.203.2024.10.23.18.43.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 18:43:37 -0700 (PDT)
Message-ID: <c92fe27f-67e0-4c5c-a3f1-b4cdd0eb0b5a@gmail.com>
Date: Thu, 24 Oct 2024 09:43:35 +0800
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: pwm: nuvoton: Add MA35D1 pwm
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 ukleinek@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org, ychuang3@nuvoton.com, schung@nuvoton.com,
 cwweng@nuvoton.com
References: <20241023111841.158049-1-cwweng.linux@gmail.com>
 <20241023111841.158049-2-cwweng.linux@gmail.com>
 <e0e4c2c9-7333-435e-88a9-129764092157@linaro.org>
Content-Language: en-US
From: Chi-Wen Weng <cwweng.linux@gmail.com>
In-Reply-To: <e0e4c2c9-7333-435e-88a9-129764092157@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Krzysztof,

Thank you for your reply.

On 2024/10/23 下午 08:02, Krzysztof Kozlowski wrote:
> On 23/10/2024 13:18, Chi-Wen Weng wrote:
>> Add dt-bindings for Nuvoton MA35D1 SoC PWM controller.
>>
>> Signed-off-by: Chi-Wen Weng <cwweng.linux@gmail.com>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Really? Where?

I'm very sorry I misunderstood the meaning of "Reviewed-by".

I will resend patch v2.

>
> Best regards,
> Krzysztof

Thanks.

Chi-Wen Weng



