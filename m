Return-Path: <linux-pwm+bounces-5685-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF4CA9A2F2
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Apr 2025 09:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B93719463F5
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Apr 2025 07:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D331E0083;
	Thu, 24 Apr 2025 07:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GXqiHtiY"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C101B392B;
	Thu, 24 Apr 2025 07:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745478588; cv=none; b=JLIg8n2va+QuJRrC+2UeCtpcJm42QezaS1+DdpRuISyWIK8iAg8aYEDfuOBE3FfYqglH8UuQH9w0/Znpveo4YWH9o7Z/KueGe9ROXRUD4S1KjrEQdfZn85cS4mDXGV9GhX7lDemTLkysVBAvohmhPDRtvYiHxDuPW36BfeEqDSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745478588; c=relaxed/simple;
	bh=UuEiPUkTylj/qy2WlmonUTfYQxAcxdMagrpv3K72TtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eNFPjJEHbpEizrVVtyroQhaGwq6i3eM20dde+OAocLE+pEOuyRmVofUcq7c0loREvzMXfGrbtMLrV/hC0v00eOA4N/RaQC52jmT3cpewO2OTgKCoLdd832fo4ILu1wtktU7ylNjY4kMLMIJqgZUHcbY1UdsBFq8s35raRO7YgGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GXqiHtiY; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22c33e4fdb8so6558395ad.2;
        Thu, 24 Apr 2025 00:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745478585; x=1746083385; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3EUZgQOVtgxwPj0Cm4KzOqZ3U97D0/GKNyUNvaflq+g=;
        b=GXqiHtiYfWkgyQPFupa58+FUfB/cMcy4yX6x8NI/pzt3FHDEELKO1ho6axTuDe2dWJ
         K+ry5Oku49iNcElVGKgzoDu3iEqwKM2Bd88qTz8VHdLrZNxyOUuZb/iWGLksdTnkiVGG
         vP8yiQ+5AWekY3+iKd10X6HPTw/NN++hHeecRSfNpcCUOGaDrix0/ZOkuFKfW5cv9RbT
         LMzbPL92I/PWaWy8Ot5pwCpLEtbnUbDrA2hdqUmaeoqDJufOWMmW1a8yoKWgKpYbHnXi
         6G8ZSLVqFV5rOzYI5CEuN4H7P+WP9+jQQspvuWDif5T5QYKBZDBxYiPbOgBZlmpzqlFS
         glDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745478585; x=1746083385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3EUZgQOVtgxwPj0Cm4KzOqZ3U97D0/GKNyUNvaflq+g=;
        b=UKq2x8uta5r0DvOwB1RshUbD/wbJgt4b7zW+TuLslrsBqQu79hVXn+FTTekGKSokaj
         65r4viLPeh9wMq8Guhec+s/TdT19J6XEHP9u7FM8wH1KFuIR7XzVNCE7JlM1VXLMedjj
         mrBlq/1IivpuqjSWszZINnRu3GJepuHGA0JBJmrfcNKAIrWxZkfQ7FM4ejTgwdEnbxHF
         /h7Yzfl9goWlW0Ux9d81Igz3zSEoeL5DUFnwYxI9orvQe+E9CxbCvmSf1K6LomKrn/0b
         d8sY/99ruy3HS/eGw2YI+7b3hD8Z5y/CzBQf/hcNoW4DcoB/1MCKbCe5k/QYNuSytt1M
         y6Bw==
X-Forwarded-Encrypted: i=1; AJvYcCUxMzd5IUoirWXHJ6YG6DsEQyqhiJ91RV5cKm/VSlJTT68U2ZmlhAHufdTloRAxGfCk4ga5n9rICCmu@vger.kernel.org, AJvYcCV7NyxVr18l1gQlCWUo5bKKDo4gZwoecrhiAkFvsI+E0oWceAFC1FiKrvH3yRGdjatiLlHTI+xiJHda@vger.kernel.org, AJvYcCVo4XQNa+axkjpPPPQeJSjZBbzHA/qi5BIw7zpS4iZfowPUB+ODGsTyQsPbxL+mCllNczTlsWkI6je4ru5c@vger.kernel.org
X-Gm-Message-State: AOJu0YzzGb0siY1cLCwrdKAYldCUyRTS/OCMtTjlvOW4AM0ly2Ox5Kd9
	4/hsWNrwN7+JIRccw1BzMHAcwGDFvpQ/wW1r9EvIYc9uZBlzc43Q
X-Gm-Gg: ASbGncuSu1WUHkmQ/VeC5pJJeYgh/Tbxe8oDtMW57RLKj5HUwi8jLUUCVIPRkAugBN2
	X+p/knSROatziDzIyCU5gJrHBV1Imt866WClIeldkc0QYYg1FryB+IEm3/Wbe7iq/UkU05pqKr6
	pZHLk3iVIoULJYp3Og9S8OhzquA3JhAUDtGe7cBNrBIflyhJhOw9r5NNx53hpG/iYP39aq9ENzD
	vHwG3e3HdS/O476Nqqya30NTNYp5SnZ2x3JQ8QwCLqbZcxAHaLmJqGljJrmTilzp5LwNEgETVkK
	JVl//LBxrYA+sCcgeTox056ov0ia4mF2A7qVe7gnKw==
X-Google-Smtp-Source: AGHT+IE9LsCk9tmFZI/PC5UZGmINwk24jJUeXSF+9kMM7rkzh8Y23OYpJUYh4V8Tdm5IfIlvZOU+AA==
X-Received: by 2002:a17:903:1b23:b0:224:826:279e with SMTP id d9443c01a7336-22db3ddbea1mr20093095ad.50.1745478584913;
        Thu, 24 Apr 2025 00:09:44 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22db50e7cf2sm6038875ad.154.2025.04.24.00.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 00:09:44 -0700 (PDT)
Date: Thu, 24 Apr 2025 15:09:42 +0800
From: Longbin Li <looong.bin@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>, 
	Inochi Amaoto <inochiama@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	sophgo@lists.linux.dev, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 1/3] dt-bindings: pwm: sophgo: add pwm controller for
 SG2044
Message-ID: <ikq5pa74pk5e26m2vinye4wanauyzwqlxrgyx7hwr27k5dk6dt@ibv3o476jrpm>
References: <20250424012335.6246-1-looong.bin@gmail.com>
 <20250424012335.6246-2-looong.bin@gmail.com>
 <20250424-bright-vague-finch-57fc38@kuoka>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424-bright-vague-finch-57fc38@kuoka>

On Thu, Apr 24, 2025 at 08:47:38AM +0200, Krzysztof Kozlowski wrote:
> On Thu, Apr 24, 2025 at 09:23:26AM GMT, Longbin Li wrote:
> 
> <form letter>
> This is a friendly reminder during the review process.
> 
> It looks like you received a tag and forgot to add it.
> 
> If you do not know the process, here is a short explanation:
> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
> versions of patchset, under or above your Signed-off-by tag, unless
> patch changed significantly (e.g. new properties added to the DT
> bindings). Tag is "received", when provided in a message replied to you
> on the mailing list. Tools like b4 can help here. However, there's no
> need to repost patches *only* to add the tags. The upstream maintainer
> will do that for tags received on the version they apply.
> 
> Please read:
> https://elixir.bootlin.com/linux/v6.12-rc3/source/Documentation/process/submitting-patches.rst#L577
> 
> If a tag was not added on purpose, please state why and what changed.
> </form letter>
> 
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Best regards,
> Krzysztof
> 

I will pay more attention to that, thanks!

Best regards,
Longbin Li

