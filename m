Return-Path: <linux-pwm+bounces-6800-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E46AAFE142
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Jul 2025 09:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DA053B183F
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Jul 2025 07:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F4D26FA60;
	Wed,  9 Jul 2025 07:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DmM/KA3x"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B75126B778
	for <linux-pwm@vger.kernel.org>; Wed,  9 Jul 2025 07:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752046013; cv=none; b=DpeMSAjD3soTTP8MVt8ANCI/jUiZJWU8WXFGeB9wo7qZSm1MMiDitX2eH2zJzpOZxDSyZV9VNYBUw8pIX2n+Y4y+GcDvUjMFSqW59TcJ1/USeGsLROaxiN/UAQBT/ZdCd3MWXlaoikKUsSs7MN9390XtCnCrMnmMtXT4xPOOY/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752046013; c=relaxed/simple;
	bh=XUUln88n+vvb0xdyre8bwQBB4xlA9ax/lxsdgBJNE7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YIdwHxXi9SJLj9Co/9VevwP3zIcK0gZlcXCZ4cocacL+6aqeOT9LsCUD2PkIKmsGdBtDQWbVALkxQeBLHi+U+tWCkyOpwop0qa7jioA0zNDZiXrTjJYW3UU9u7am+Hw1nkf09xbJcE8BJ4HknvVcCW51zDtCQ6jFpOIssZGQpVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DmM/KA3x; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45362642f3bso4880275e9.2
        for <linux-pwm@vger.kernel.org>; Wed, 09 Jul 2025 00:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752046010; x=1752650810; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XUUln88n+vvb0xdyre8bwQBB4xlA9ax/lxsdgBJNE7Y=;
        b=DmM/KA3xuBI0/OPfUVznu9NTCcvfap28gJo/ahoTSa7OkVVEDYilyY00dI739FqxyK
         ZYeGvM4Ce+N0ym3cwhaq/35OIUHi0ZBaRbv7zJN5qQ9nhzjL2JokYIYxaZmw68ucmiMh
         CdEgyZRNu7eKe5fOQTpJuD9uhf9Bw5oy5guhlD3elphGtM8N+8+U4H2dLcxDK6ghxwhD
         VQ/8hMh5iZaMtr6G/vI84MFZo68zyXahceZYYFpdcrwl3n84IkaXE4Ine/CTXOnXF0oH
         QJKPV1T+0OrfsMv86Mm6Ti2M486EEjY5W2N6PFPs8oZKqQa9ARt/a3KK7e//HaqYnsAO
         fVnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752046010; x=1752650810;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XUUln88n+vvb0xdyre8bwQBB4xlA9ax/lxsdgBJNE7Y=;
        b=RNQXiFq9CYurE3U0USs9BRiwj9ltii8yeCfz2FVuy875dnjKmADPeK25g6XWYkt0Oh
         2d4YNkpKSOqZW1CUFUiBWDL7uaGRUHoPofhidY2r3p7xhSAIPLhGX71tetmpawKxYoej
         yT9XnaF5FotnPWxrJkfgXPys1jaFqRULqZvYPrkv/AK5nH8eVCVbDw0O45zyAhEpg3QN
         YZAZvlIOV7dDBuG4e77cXxu+lfdqX8TdWjf1+96Z1zG5/xDxTetbsh8mVwP4Cwq2fJyZ
         OPcr7k1vFoDZ6qZ6/qeCN47dwrtNwrraLmj5ZcrhV1lHzlTQPSOga+9klEOMPG6NXoHc
         mSCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOFvErHkehVSJb0eXIjwFEeuGo34JrSO5F75RX0clTxUriw2Y/bd7cKpy7GFzlQ/idOQxEdVzC4so=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVsJE1MZLvDfzCFh9AYZO6vtiT8UUM1DU6UzeXZ/l5JHcevyFv
	1rrumjSRgU2VG9eQ41WhTQCbrFK2eFjqHzTVMRkqE8Y/Qzgxh9o9eDoolouD6ErgN9w=
X-Gm-Gg: ASbGncuF57JndeV4zQz9dy24e5IioqTH15z8ZmHMnYqCiOJ6fe4xOHT9dMQyMvggteb
	0bqa7ZD/mC8C1a6IPNmQx1h/hN6MytsbCHEPnU+/1E+RPouCsyvh57QYQhTnWJCrVodsEx2Tpbv
	Zjp3wYhXJlHyAKrrmBEWs1QyIePWPnD6kT022VGt2ddnrCXmQeN+FlKLaMLU+vgfh8X2L9EQjlR
	sOHHmaOe3d95K9woNOuu0zEt2b58meJcb8Fx1sDXZZ2A0kJb3AeyqJQqJZjmAKQncUhDjuVEQwA
	XuvWjSTKJXXFtiRmx3afLVw4s2WlgftBvBEEVEUfuxZafq4/fjuJyKurXNYyTGHH5QSESOHM2Md
	sRSJxFA==
X-Google-Smtp-Source: AGHT+IHZpo9yVzRnXdUKvTXY9ZQtWtBLdKSOZfU7YVv7hkzlMjlyi3VsozBWY+UWea6vDF42mm0qzQ==
X-Received: by 2002:a05:600c:37c5:b0:451:dee4:cd07 with SMTP id 5b1f17b1804b1-454d52681e5mr4298385e9.0.1752046009717;
        Wed, 09 Jul 2025 00:26:49 -0700 (PDT)
Received: from [192.168.1.110] ([178.197.222.89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b470f871casm14962751f8f.45.2025.07.09.00.26.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 00:26:49 -0700 (PDT)
Message-ID: <3f2938ce-8045-44dd-aee6-542779cd9916@linaro.org>
Date: Wed, 9 Jul 2025 09:26:47 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] clocksource: timer-cadence-ttc: Support TTC device
 configured as PWM
To: "Rao, Appana Durga Kedareswara" <appana.durga.kedareswara.rao@amd.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
 "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "Simek, Michal" <michal.simek@amd.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
 "git (AMD-Xilinx)" <git@amd.com>,
 "Vanukuri, Meher Thanmaiee" <MeherThanmaiee.Vanukuri@amd.com>
References: <20250115113556.2832282-1-mubin.sayyed@amd.com>
 <20250115113556.2832282-3-mubin.sayyed@amd.com>
 <hwnhz4yr6vzz3oav4gq7qptejjy3rdwff7iveawaxexf3tbngr@pnrxi6jkpw3k>
 <DS7PR12MB824987018AAB745E38C638728F7CA@DS7PR12MB8249.namprd12.prod.outlook.com>
 <DS7PR12MB82495FE4A65F266D0857EB408F49A@DS7PR12MB8249.namprd12.prod.outlook.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <DS7PR12MB82495FE4A65F266D0857EB408F49A@DS7PR12MB8249.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/07/2025 08:51, Rao, Appana Durga Kedareswara wrote:
> Ping!

You responded after three months and now you keep pinging on that? No,
implement entire feedback and then start working on recent Linux kernel.

Best regards,
Krzysztof

