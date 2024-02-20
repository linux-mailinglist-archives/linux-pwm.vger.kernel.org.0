Return-Path: <linux-pwm+bounces-1567-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 969BD85B81E
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Feb 2024 10:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E99B2B28899
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Feb 2024 09:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EEA67A0A;
	Tue, 20 Feb 2024 09:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GB+iInto"
X-Original-To: linux-pwm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F93067A0C
	for <linux-pwm@vger.kernel.org>; Tue, 20 Feb 2024 09:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708422388; cv=none; b=NThwU2T6pX60803/pUOGdcjk1bbgPsub6QAM3MkWQGEaNxsvoLy8gzfItYrC+nJM8qtcx3X6hBbSwfArG52IdAc2ObZjhTawjDNjG/2clGxSgElQPg68nXK2adYwZhA+eBAu3gnEXytBDUD4VLgFCP4ghtf0gwJ+PIZoOuS+Mug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708422388; c=relaxed/simple;
	bh=VU6lUw9k90PuFwFfUzpvE+ClWSw7Z6+NspthVyDjW7w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C7WcZYMaa5uj8yfpBJqq6zJ8HQkh6m8Jf2OSMPqlj8yD8tYDxe35gtVLWZu5mfAmyAT77REvBLpk17qDt2r7sxMvzjOPegNUfUyj1GB3IugDSUK6KPmhKhYrWYQBMF/rqrIfdeWVfZFJgWtrWSYBPaq7Op4dfOoOs7rp4TuQOCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GB+iInto; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708422386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ua+iueUGl77okzhaoQdUc6zme30b1qrWNRG/YazNKLc=;
	b=GB+iIntocFLIeNPkrzRL1cYz5KKqQy03ZM7foNrmbcaLsOUSQEAJ1TDlOH59nPwzSn5KBv
	WVodOqXeiZceXXdWKv/iQdCw3WYPcsE3lBNnTdQpFrYF8omgHQI+0uaUqiuJ2m+kmTaa/g
	lI5mso8tBC0unm4YuSbc2R3aPK9weus=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-GvkpHARuMMiHM9mO2sNDmA-1; Tue, 20 Feb 2024 04:46:23 -0500
X-MC-Unique: GvkpHARuMMiHM9mO2sNDmA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4107469e8adso33032815e9.1
        for <linux-pwm@vger.kernel.org>; Tue, 20 Feb 2024 01:46:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708422382; x=1709027182;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ua+iueUGl77okzhaoQdUc6zme30b1qrWNRG/YazNKLc=;
        b=i5jQ9K44tmn4+v/ZmsBL8MrigROLBplmf51YBe65P1Ykrsm+xGBkO7p9PkLoFFfeWH
         KNtSXhqTY7dStBqP5iQ6i48FZaDS8Cuucb5KGIcG7YokvlVx7r/mJB5uoE5oLQa5S3m3
         nLVqOVcY4NPS4/908cmYO46U3g4nE3M3NNUCdWnA0Y+IHuC4E5a/mqNnKiecVYlodMbh
         V3YVJ2Au/aq3cic2bodm/XS0LHrmxU3pJao3ytg/WVkKs8VJe52xAPpBpL6w0vbCNVZB
         xaIbfon9nLSiSUIms4dn8DBqCKDQjVA4L0EvpqUtypIEb3xo1DESY0kEfFeliLO/bPr2
         CnkQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0vXVjBZOZ41LWrqXQDfNyrJ13u8RXOZegENvxW0mIz0eoRKLHb3CRc7asZft/RpuCVUZysFzP/LKZe0sUNCbWCflyjDEmLp3R
X-Gm-Message-State: AOJu0YyNCJufkk5nIYuq/vVWTUbBJrJ0VdFjhgL4kJed+zRUpKtpqtv6
	nRO7zg02lmUBINKaZFjhGoTR6kyk+wRw+qD3T/Y+/x2ji8WrR5U/ubPURvDTP9wSO+lBJrk9TZD
	9rzaycep1TfMxWLdR6qwb9UDmY0cBw2nqC9X4JQ4INlhzaKA0nsI4SE/F+A==
X-Received: by 2002:a05:600c:4813:b0:411:fae0:b158 with SMTP id i19-20020a05600c481300b00411fae0b158mr10243408wmo.35.1708422382793;
        Tue, 20 Feb 2024 01:46:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVewDRy1qipC9k0gZj2P7ww2xioxl7Ke3sBkdfIzbrcFreEU44DweZYKlUDvIymqIYAVgmSA==
X-Received: by 2002:a05:600c:4813:b0:411:fae0:b158 with SMTP id i19-20020a05600c481300b00411fae0b158mr10243398wmo.35.1708422382457;
        Tue, 20 Feb 2024 01:46:22 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id k10-20020a7bc40a000000b004101f27737asm13892556wmi.29.2024.02.20.01.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 01:46:22 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, lee@kernel.org,
 daniel.thompson@linaro.org, jingoohan1@gmail.com, deller@gmx.de
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-input@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 01/10] backlight: Match backlight device against struct
 fb_info.bl_dev
In-Reply-To: <a5b9a2d8-f305-4b68-9086-76d5f1b985c7@suse.de>
References: <20240212162645.5661-1-tzimmermann@suse.de>
 <20240212162645.5661-2-tzimmermann@suse.de>
 <87bk8bjxzo.fsf@minerva.mail-host-address-is-not-set>
 <a5b9a2d8-f305-4b68-9086-76d5f1b985c7@suse.de>
Date: Tue, 20 Feb 2024 10:46:21 +0100
Message-ID: <87edd7ii36.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Hi
>
> Am 20.02.24 um 10:17 schrieb Javier Martinez Canillas:
>> Thomas Zimmermann <tzimmermann@suse.de> writes:
>>
>> Hello Thomas,
>>
>>> Framebuffer drivers for devices with dedicated backlight are supposed
>>> to set struct fb_info.bl_dev to the backlight's respective device. Use
>>> the value to match backlight and framebuffer in the backlight core code.
>>>
>>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>>> ---
>>>   drivers/video/backlight/backlight.c | 9 +++++++--
>>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
>>> index 86e1cdc8e3697..48844a4f28ad3 100644
>>> --- a/drivers/video/backlight/backlight.c
>>> +++ b/drivers/video/backlight/backlight.c
>>> @@ -98,7 +98,8 @@ static int fb_notifier_callback(struct notifier_block *self,
>>>   {
>>>   	struct backlight_device *bd;
>>>   	struct fb_event *evdata = data;
>>> -	int node = evdata->info->node;
>>> +	struct fb_info *info = evdata->info;
>>> +	int node = info->node;
>>>   	int fb_blank = 0;
>>>   
>>>   	/* If we aren't interested in this event, skip it immediately ... */
>>> @@ -110,8 +111,12 @@ static int fb_notifier_callback(struct notifier_block *self,
>>>   
>>>   	if (!bd->ops)
>>>   		goto out;
>>> -	if (bd->ops->check_fb && !bd->ops->check_fb(bd, evdata->info))
>>> +	else if (bd->ops->check_fb && !bd->ops->check_fb(bd, info))
>>>   		goto out;
>>> +#if IS_ENABLED(CONFIG_FB_BACKLIGHT)
>>> +	else if (info->bl_dev && info->bl_dev != bd)
>> If the driver doesn't provide a struct backlight_ops .check_fb callback, I
>> think that having an info->bl_dev should be mandatory ? Or at least maybe
>> there should be a warning if info->bl_dev isn't set ?
>
> bl_dev can only be used for display drivers that set an explicit 
> backlight device; otherwise it's NULL. There seem to be systems where 
> backlight and display are distinct. And the docs for check_fb say that 
> by default the backlight matches against any display. I tried to keep 
> this semantics by silently succeeding if neither check_fb nor bl_dev 
> have bene set.
>
>>
>> The would be a driver bug, right ?
>
> I assume that some systems create the backlight instance from platform 
> data or DT and the display driver has no means of knowing about it.
>

Ok. I thought that in that case a (platform specific) .check_fb callback
would have to be provided then. But if the semantic is that none could be
missing, then I guess is OK to silently succeeding.

I wonder if at least a debug printout is worth it. But maybe a follow-up.

> Best regards
> Thomas
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


