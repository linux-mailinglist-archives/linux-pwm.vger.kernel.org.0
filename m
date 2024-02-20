Return-Path: <linux-pwm+bounces-1563-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D8385B78B
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Feb 2024 10:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 980DC1C20D7D
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Feb 2024 09:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D668A5F875;
	Tue, 20 Feb 2024 09:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TNdDNsys"
X-Original-To: linux-pwm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDDA5F47D
	for <linux-pwm@vger.kernel.org>; Tue, 20 Feb 2024 09:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708421536; cv=none; b=VA9+ta1B0PGfIDoOeXYwT737Ix4Mo/GyI1EWXTDbF9YyRJTPUNhkXKohBHQ2/FaAsSJ0zMBBzArQFzskygSChiypPR8QKqRW+MVUKSPmiAnEKF8RMngFHfbd9RAjkJ7xfZPso8HmpebjzCOdQk/BlUZCmSz4FU29yiM+VZ7BZt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708421536; c=relaxed/simple;
	bh=goefrht0JH8QKHu3jtM+Rmfsru257+PSg0UBzrNOVVg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B4hj5wOHuKQLgC4s5H8dQMh3mmLzEeW2d68ZrunJIlSaNMLBpqvrClFKO3Q9py9myvHV+Pox1rpwjGDDM+vncF46lKM4m8AIogLTbObyU/CB3u8h9baz+XwFcSIV42pROMfi5oqsk+1ivaXo5b30WCmca2YHvtT+JrPH/QouEuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TNdDNsys; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708421534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UgQ2TOsHUa28odpvYARLjplwl26hv5UH7grcAVsUCtU=;
	b=TNdDNsysBOLIit9T45R7S+Dd5kR+LfYredgFxVhFoQGcKjgvJeYi2gmuxNxR8UAsrUbc9Z
	0QSoMTzq2PZaJ7LvERNgXLTEN7dQxZubeP1Iu+1emEJmwSTgsrhtQrxP3Y2lv7QTC+UuIN
	Bo+fqmIhK8U1KpZZyFRi2ZceblLX0Ts=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-RPrJ8VlnOx6HoPwcKx5sVQ-1; Tue, 20 Feb 2024 04:32:12 -0500
X-MC-Unique: RPrJ8VlnOx6HoPwcKx5sVQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-337a9795c5cso3253114f8f.2
        for <linux-pwm@vger.kernel.org>; Tue, 20 Feb 2024 01:32:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708421531; x=1709026331;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UgQ2TOsHUa28odpvYARLjplwl26hv5UH7grcAVsUCtU=;
        b=HvWRJibi7WhtXqPmGeJHt1yts5aq14hdT8VEu6fuaDiKfMqyprlrteHQoyHJlkPUJB
         nK/UNdVP+XMLVTxV+3f3bLiUD2UqkjhgB64oXoYJIkY9QIl8KxLJyVynwc7S6use9A4U
         kl/D7z0S8YLYvbVRfFvhNRW43X/nBRShDVDb/LuQ02JoxaUym9YAyFvALcYn/V0KWgdV
         qSb9tn6J4tPRaOk9BhLaY6AHrE3vSMJm6+UVDFVCEGJ3/gMv5mKxDHcqLFFSj73b+e0a
         bKt8Oe5Mgd/9Q6FBXZBgtpBhTJ1xOwBkfeYOatGreel0XMIXgvyngryk9GgZNz/DQ7eG
         xZEg==
X-Forwarded-Encrypted: i=1; AJvYcCVecAFup5p5JM4sIVuIQ1GgVDXwlOxh3CazFEgkXA7gxBotIHJocE1SLg7/l+/H/oC7dCzrl2FEc6g7ILI79P4/MEuHwmWVOwIK
X-Gm-Message-State: AOJu0Yxjryp5C1K3J8ZV4s8NUPLtVOvSpxUzBm0jhQ84zwkWu/mbRWR4
	VG8JDNdVAV7gC1LE6AoTFpjXZ5Q0WpwWwWkGwWe7rM1LGIDIIBofvJe7YPqkKumxhsHvVrrcHtH
	bfSCuQvXOar0QpxHSSmPqazbxBzBZXl48cbOd5D70nOc/ldx8xHbrZ1XWcw==
X-Received: by 2002:adf:d1ef:0:b0:33d:2198:f2fc with SMTP id g15-20020adfd1ef000000b0033d2198f2fcmr11356572wrd.2.1708421531491;
        Tue, 20 Feb 2024 01:32:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdwptKNJDBk60dmyPKyprwG07LhUuoJDUqZ2pjMagOouw3ZsYtr+PHgpSM/sz1pGEotVfdqg==
X-Received: by 2002:adf:d1ef:0:b0:33d:2198:f2fc with SMTP id g15-20020adfd1ef000000b0033d2198f2fcmr11356555wrd.2.1708421531169;
        Tue, 20 Feb 2024 01:32:11 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id r10-20020adfda4a000000b0033d3b8820f8sm7738442wrl.109.2024.02.20.01.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 01:32:11 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, lee@kernel.org,
 daniel.thompson@linaro.org, jingoohan1@gmail.com, deller@gmx.de
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-input@vger.kernel.org, linux-pwm@vger.kernel.org, Thomas Zimmermann
 <tzimmermann@suse.de>
Subject: Re: [PATCH 08/10] fbdev/ssd1307fb: Init backlight before
 registering framebuffer
In-Reply-To: <20240212162645.5661-9-tzimmermann@suse.de>
References: <20240212162645.5661-1-tzimmermann@suse.de>
 <20240212162645.5661-9-tzimmermann@suse.de>
Date: Tue, 20 Feb 2024 10:32:10 +0100
Message-ID: <87r0h7iiqt.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> For drivers that support backlight, LCD and fbdev devices, fbdev has
> to be initialized last. See documentation for struct fbinfo.bl_dev.
>
> The backlight name's index number comes from register_framebuffer(),
> which now happens after initializing the backlight device. So like
> in all other backlight drivers, we now give the backlight device a
> generic name without the fbdev index.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


