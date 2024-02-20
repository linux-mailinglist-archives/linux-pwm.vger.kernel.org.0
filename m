Return-Path: <linux-pwm+bounces-1562-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0742685B75F
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Feb 2024 10:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39CBB1C24647
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Feb 2024 09:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DC35FBAD;
	Tue, 20 Feb 2024 09:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MnEpWMj0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3C25FDB1
	for <linux-pwm@vger.kernel.org>; Tue, 20 Feb 2024 09:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708421274; cv=none; b=rc25fWOOu4/mNXbWrLnbKRTMoqojDnRWPKcEbCBtNC5HxxpzEeaU2W0pVEGC6f9iVb6FunjZoxp/6V1H9cxGbtS5Jum3YxkRtX3WYxBdvvZkKQetC0fiN7BkHTdc2W8DEDSv4Y0uLRRmrDsuwUKfc0Gwceoh3a+IVU74J2jMx7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708421274; c=relaxed/simple;
	bh=WrnpVBUoYjGoDOOrj0S02mflbU9UnxAKN3MjYxaIOA4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uU/dJMsqC1NCtW+ltq7FtpcOzwC+nPlhK6ABU46+bqgIqVhjOOBuB+xIPd7cZFUCF9RyqWo0nJWVQiqUcJKoS7yJo44PJTCnevd/xqSFvL5dK99cMaE1JFw81CWaHzTnmtH8LCZDES3ShhhrYni2YSSO8ecIy7fYcSQRm/EPGkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MnEpWMj0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708421272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=obRxtLx6rLeO3YU/rqnXda0xS0dHIkiSbzya77n1Jfs=;
	b=MnEpWMj00gOQkqOmQczMdrFW+Iod0nGhLRNuoe0lIEh71XN9uVdjYBO1iwSFWLHcWakX5X
	q4ZskszBNiv2XkV5MLRlg9/UpEkPislMjCGkWDyURxmUfLjPlZW+r35BagzSJ41dMdmdfK
	q230nFN5lzX8grIVKKLe2foRKLWWulY=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-FkC1PBtwM6-tXuKdwwKlpw-1; Tue, 20 Feb 2024 04:27:50 -0500
X-MC-Unique: FkC1PBtwM6-tXuKdwwKlpw-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2d230281e63so19462271fa.1
        for <linux-pwm@vger.kernel.org>; Tue, 20 Feb 2024 01:27:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708421269; x=1709026069;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=obRxtLx6rLeO3YU/rqnXda0xS0dHIkiSbzya77n1Jfs=;
        b=dB3FeIsBY4lNVUzH+/PCdyhbCvQKeLxBulsDhmVSpsBhd0DDyGPLesK0s0COYzWoGp
         EWR8sYEC57wvNgPK5zJt8df7BD3DrtpIohD2pSM6ToZyV1x4ajO1Tps4J62DJyg3q1mN
         DNtwGjgZcXIaCOoUliH9MF0+q1YBJIdpFcFGpjPcOzVBgpT5uY09YfOYT5r/DCz4cEJw
         +5uA7OUqEUuw6X73YwUS4CNQ3WCpFNZKooJhEavKk8uce3r5RmtTiR9X6WlVgPK91+TS
         FX5n5h3xArBEp9AcPSZ1nr5AAqJ895fHD6Kx8QDQOtfSvO+GUREyZB5Sph1MOXkVDw5j
         p/ZA==
X-Forwarded-Encrypted: i=1; AJvYcCUt0eZ+EB0NMWtB1wtRW206p99G3rnNXontnudcGXBdXxzW65EeLDZpx2pAYm3SDet+oh/eKjfmYEXzsLPiMJXSqcsaC+uYDf7e
X-Gm-Message-State: AOJu0YzqpEWCNB/xJHdVRQl7XM8vGQ39zgr7L4+rUk3NbDSQPokNlFPj
	iMr0bGgJ69GWrbT+INBHy2lBoBS/hISp/SRNQngKKq12R9GvL5s3eotftkxtRvw2l7PE/ENfjS+
	zxkHSG2fmX4N57DMtVReHrEDkAkE8TMYPJuU37F5FNy3TuC2fQkrtF4rWkw==
X-Received: by 2002:a05:6512:203a:b0:512:b362:e790 with SMTP id s26-20020a056512203a00b00512b362e790mr3016710lfs.34.1708421269260;
        Tue, 20 Feb 2024 01:27:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFa5OX+BOUymJZ7SlIgyg3cW7L8Ltr9UOF5eSo06b5LnwaixDwHdhkSc1ftkjut2C8Il/ElUg==
X-Received: by 2002:a05:6512:203a:b0:512:b362:e790 with SMTP id s26-20020a056512203a00b00512b362e790mr3016699lfs.34.1708421269080;
        Tue, 20 Feb 2024 01:27:49 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id ci3-20020a5d5d83000000b0033cf2063052sm12834029wrb.111.2024.02.20.01.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 01:27:48 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, lee@kernel.org,
 daniel.thompson@linaro.org, jingoohan1@gmail.com, deller@gmx.de
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-input@vger.kernel.org, linux-pwm@vger.kernel.org, Thomas Zimmermann
 <tzimmermann@suse.de>
Subject: Re: [PATCH 07/10] fbdev/sh_mobile_lcdc_fb: Remove struct
 backlight_ops.check_fb
In-Reply-To: <20240212162645.5661-8-tzimmermann@suse.de>
References: <20240212162645.5661-1-tzimmermann@suse.de>
 <20240212162645.5661-8-tzimmermann@suse.de>
Date: Tue, 20 Feb 2024 10:27:48 +0100
Message-ID: <87ttm3iiy3.fsf@minerva.mail-host-address-is-not-set>
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


