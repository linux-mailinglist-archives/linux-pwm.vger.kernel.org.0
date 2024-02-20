Return-Path: <linux-pwm+bounces-1565-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8264285B7AE
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Feb 2024 10:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13071B24823
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Feb 2024 09:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16878612C2;
	Tue, 20 Feb 2024 09:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d/yxXXE5"
X-Original-To: linux-pwm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69914612DA
	for <linux-pwm@vger.kernel.org>; Tue, 20 Feb 2024 09:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708421761; cv=none; b=eVqlausdCkgytybc6vykBzzTDH7Y+DWnz/ikpZO7V0ZjJdZXLFv074xuJ5eax1OPJ9n4V/bhWc5uo0ZmR2sDuz5LL/GbevXmL8obtCvfoeZZyGXpZyh8WaNH9/XHgtfg7lLiMA4J3d21SW3axkZaxyVsy7AMxf/iaLSaEI/YXHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708421761; c=relaxed/simple;
	bh=VnAn8uZAJT5vkIYnj03sUb9gmxZzfSWHD4320ZoQ8KQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ebr8Uu0C2G35KzKTVBwGvuAZNAY2SA2Rgz6P5NngCS2fc5/l2EB7e/rYrHTUcYm3/52Q3x1aWA3mfHg+z0zElLMaF/OEO3+7m6ujkFsS2jamOwRaCnnRDUWnmErnluTOHh82i4fSwa3ax55mAaeAu7HYMmO4Ob09ojunscqKEe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d/yxXXE5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708421758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9Hgn9WqXu1AhhX6E5+lsbEBu8N0fTK8tYmqmiPGcClA=;
	b=d/yxXXE5mVcQzs9IBDf/o3hGuISJjRK1hOLTyruyDWQ1IiwFmGbxYFck+0rc3jTfQb2Ax6
	YWpckt9B11TmRCUmHs84J1NH80vxi+5aScuCrgPVoaEnfsXycYG2PpuNQb2LW8Z7qa0Uv/
	qH5Cj3oQ3wy55VS8JWdoxXCwazwlc7g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-WuwN27RMOIaixeap4KBF-g-1; Tue, 20 Feb 2024 04:35:56 -0500
X-MC-Unique: WuwN27RMOIaixeap4KBF-g-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-411dca63c56so20922915e9.1
        for <linux-pwm@vger.kernel.org>; Tue, 20 Feb 2024 01:35:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708421755; x=1709026555;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Hgn9WqXu1AhhX6E5+lsbEBu8N0fTK8tYmqmiPGcClA=;
        b=HEgtvurgHmEkSPzL2XeZp7GODgfERQnIsJ2bSJYYbOHpgFomv4Ps26l3/nwOAeprsM
         X+kqY+uSnfVWx0jNaU28zqNxICGMnMrtaGUaDNuUV8g9RbIH73LLjm/RwQUJdYnSGDH4
         1lJCMYy28NJ4pgmZkz0mb31jX3RqBf+6tgD7me09s9B8jmMu1BCU/Aj2J8M00cIPB34p
         GZT7YIPdQR7CMEdvdOJbHK108tQbll3PaHz+qb3wc9k+31lpXiolYKsuh3/MPy2y9b9E
         DF2Hc3nD+AYe8MT7r5VKUiQvJOxyov5Yj+Fz8k6UaRN67lzXuu3C8qjd18otknYf+5j0
         noHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBe8UQnpL3PK70ZGB23h0hpeWtJqGqJJ2//KSl895VHrFMh3VfuFk31cJZ2yute8IM4jBgD1267xoajlY7q8LUSqOxWskaFbT2
X-Gm-Message-State: AOJu0YyS9Lbkrpt/VoXZuN2SgIRxDG/hKhKH0cQgaKwB2Jt7Z/VtFOxm
	vyp7oifk+Iwmf92QnKxAjYejR41qCcMovm5mRSKJIsD+bI8YeaaynM7/goZtc4qxaDRSzxXGJ65
	gpd6jF6l3yXkfwINca7PXFFcuOeU6+ITz0VFEj4PAsSUia/GGP5jc3Rmlyw==
X-Received: by 2002:a05:600c:310f:b0:412:68a1:1020 with SMTP id g15-20020a05600c310f00b0041268a11020mr3013468wmo.17.1708421755414;
        Tue, 20 Feb 2024 01:35:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+JttJJiDku7kTZxlbPK/PYMKWsh61tt639P+Ab793uMc5bDoYOmRxrg62ZITenPVeeiMypg==
X-Received: by 2002:a05:600c:310f:b0:412:68a1:1020 with SMTP id g15-20020a05600c310f00b0041268a11020mr3013458wmo.17.1708421755137;
        Tue, 20 Feb 2024 01:35:55 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id 21-20020a05600c229500b0041228b2e179sm13843333wmf.39.2024.02.20.01.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 01:35:54 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, lee@kernel.org,
 daniel.thompson@linaro.org, jingoohan1@gmail.com, deller@gmx.de
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-input@vger.kernel.org, linux-pwm@vger.kernel.org, Thomas Zimmermann
 <tzimmermann@suse.de>
Subject: Re: [PATCH 10/10] backlight: Add controls_device callback to struct
 backlight_ops
In-Reply-To: <20240212162645.5661-11-tzimmermann@suse.de>
References: <20240212162645.5661-1-tzimmermann@suse.de>
 <20240212162645.5661-11-tzimmermann@suse.de>
Date: Tue, 20 Feb 2024 10:35:54 +0100
Message-ID: <87le7fiikl.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Replace check_fb with controls_device in struct backlight_ops. The
> new callback interface takes a Linux device instead of a framebuffer.
> Resolves one of the dependencies of backlight.h on fb.h.
>
> The few drivers that had custom implementations of check_fb can easily
> use the framebuffer's Linux device instead. Update them accordingly.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Personally, I don't like the "control_device" callback name that much. I
think that check_device or probe_device would be a better one and easier
to understand what it does.

But not strong opinion on that,

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


