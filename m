Return-Path: <linux-pwm+bounces-1564-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6403A85B794
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Feb 2024 10:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 804721F286C4
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Feb 2024 09:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1CD5FDB2;
	Tue, 20 Feb 2024 09:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IP1A277j"
X-Original-To: linux-pwm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3565F47D
	for <linux-pwm@vger.kernel.org>; Tue, 20 Feb 2024 09:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708421555; cv=none; b=nt0oX49AYx7R08aLzwjSZF6odMm5GmK7Ok/Ah6YKa3D8plEvxe00WLUJi9o3XNwyXcnZ9g8N1Uy4qI98noDrfM+hWMljdXXbBPdww/khxhVS1ralKkqhxho+5OwgSyZg86H2l0PiFCkn8Ni+h7FdVJIUNwOPptPaTaL2+DkZMvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708421555; c=relaxed/simple;
	bh=WrnpVBUoYjGoDOOrj0S02mflbU9UnxAKN3MjYxaIOA4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=htt+A9HfV2fSk80K4vImRgFDQPxumXQQACyZU/p/y32jWx0Im+kErDC51Z1ntJwu/HfeEXTI/qbPX/KdldMGEemrwtcXi4jkDuAGw1RKslEjFvabYDLJj8tniv5LuHMQOBpfne3/yHD2mnY1WYg4KDL0p1PBdC+EKwRSHuWYsrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IP1A277j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708421553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=obRxtLx6rLeO3YU/rqnXda0xS0dHIkiSbzya77n1Jfs=;
	b=IP1A277jZBxXo4BKK+8NajA700NzNhBGYcBlA12okI1IZGn+ZJLTLJDxng3Aqn220D/FNz
	BSsiRp6fVMzhcHekr74nEWJMg49XynfMourT6eK60UGVimSL8jFvwscyVJW3tnXSIMeOox
	fPHZ5vZsbgfhsxm5pc9BB8NQjy99big=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-IHQtIBBrM6mwLf8-t_nubw-1; Tue, 20 Feb 2024 04:32:31 -0500
X-MC-Unique: IHQtIBBrM6mwLf8-t_nubw-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-512acebbafaso2085567e87.2
        for <linux-pwm@vger.kernel.org>; Tue, 20 Feb 2024 01:32:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708421550; x=1709026350;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=obRxtLx6rLeO3YU/rqnXda0xS0dHIkiSbzya77n1Jfs=;
        b=YJ5v61jpbGSMI1RzROXQhlHLO8wvvtn2iP02O/FxCbYnFLe6C0Gllp2AlUk7aQx7My
         PpEvqHlvg77UdoZuYS3NY9yhi/4AizcnM4dIBowRH1lZecT2FNlKIhYM8oZh/NQOWfOH
         CCHHChvuCxPB9C83Bm9jekWe5UZIoajPoBrX2oj6xnL7ewHG8si9vwQnbFUN0TkfFPSw
         TmFD/p9UGyW6eWAFlD5qJx66WIbEl8Awfna6Efq2O+GoLWiqXSAzjt3ogbRKR32TEd7M
         J4icfLD0cSrywbh0UbR6/4ZPJ4BKGAz3VXYe9ESl18Hw0ySJ5/htnn3uF26UQSTP9Sxb
         fkaA==
X-Forwarded-Encrypted: i=1; AJvYcCVjLiFBd2VVUPTpcuRo3i9FdbvVi/zxU71iTeXUJZj57KBbnvRGAN2Z8kHBBdFPQAt7YitJ0Hs5LY2QfHvEUD+bia+6CrFj3YWZ
X-Gm-Message-State: AOJu0Yz6ar55HWQogevZEGNjYAAFBrjmzelYjKaBAz/Bg9mHzS3vKLTU
	A6hHTy3wqUQ1qKGz2TjrEpuCgy/MD69LNu4724SwlVI/kMEQJhLzCWY1p590neeACv0XHxpqhST
	mKa16XA4OuxIRRznJNC2fbmbU7XulMqFrggCv4RmBqoIctOmDgY5owfV+cQ==
X-Received: by 2002:a05:6512:239c:b0:512:ae18:7492 with SMTP id c28-20020a056512239c00b00512ae187492mr5795450lfv.11.1708421550180;
        Tue, 20 Feb 2024 01:32:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFK1ISvscWSiC+8duilezYgsz5C5byx70dEu3G6Io79efRQOyltpTKPLus1FsPEKi437suJg==
X-Received: by 2002:a05:6512:239c:b0:512:ae18:7492 with SMTP id c28-20020a056512239c00b00512ae187492mr5795423lfv.11.1708421549884;
        Tue, 20 Feb 2024 01:32:29 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l20-20020a05600c1d1400b0041256ab5becsm11246103wms.26.2024.02.20.01.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 01:32:29 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, lee@kernel.org,
 daniel.thompson@linaro.org, jingoohan1@gmail.com, deller@gmx.de
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-input@vger.kernel.org, linux-pwm@vger.kernel.org, Thomas Zimmermann
 <tzimmermann@suse.de>
Subject: Re: [PATCH 09/10] fbdev/ssd1307fb: Remove struct
 backlight_ops.check_fb
In-Reply-To: <20240212162645.5661-10-tzimmermann@suse.de>
References: <20240212162645.5661-1-tzimmermann@suse.de>
 <20240212162645.5661-10-tzimmermann@suse.de>
Date: Tue, 20 Feb 2024 10:32:29 +0100
Message-ID: <87o7cbiiqa.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> The driver sets struct fb_info.bl_dev to the correct backlight
> device. Thus rely on the backlight core code to match backlight
> and framebuffer devices, and remove the extra check_fb function
> from struct backlight_ops.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


