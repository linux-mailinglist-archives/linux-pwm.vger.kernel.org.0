Return-Path: <linux-pwm+bounces-9687-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HKyrEjXdUGoe6gIAu9opvQ
	(envelope-from <linux-pwm+bounces-9687-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Jul 2026 13:53:25 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 952BA73A728
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Jul 2026 13:53:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=UODODA5D;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9687-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9687-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F24BB30137B2
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Jul 2026 11:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD574071E2;
	Fri, 10 Jul 2026 11:47:31 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D131E400DF6
	for <linux-pwm@vger.kernel.org>; Fri, 10 Jul 2026 11:47:21 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783684049; cv=pass; b=Q7/28hl3vVU1DDoC5RKSvs/RDgniMkRWzuU2j6vBiylkitl9jfz4YYZsOOK7UicH9D6oD4pXrfBKpaLhzaV70JI9f8zvfOCKlcbtt7GYQzJbfF3pNvipqX4e1/uZ1x+yfM4lvYRi+xvjdjcL/c5hehQp9JRnU618Qov6wwCMMkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783684049; c=relaxed/simple;
	bh=Yz51h6ZFZp0eaO5wOQ0hjXGgJ1wSDILNIZsGWGdqINc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dd55UkipV0Zc680c5OeyCJhHk2kP3cgJwYpAWea0XmBX74jS47fJgzUDkVx8ewkKnh5m9WWbikjJf3ID6nStLcXmhpXdfaL3gus5aAsUHnOB2I3ymg1/tRPF54lK7dzO8QPdIP2Lk0qXITcUzqxkrSfXT94zMEjWsJJX0DWrKys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UODODA5D; arc=pass smtp.client-ip=209.85.167.48
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5aeae350e0aso969664e87.1
        for <linux-pwm@vger.kernel.org>; Fri, 10 Jul 2026 04:47:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783684036; cv=none;
        d=google.com; s=arc-20260327;
        b=BMHgGaFrOyHpq8GK143KebeZm71yKKkf6syfcm3WAQJwKtTlihsERv/sXczaIDM8xp
         beyfTfaOFAGv61KNGP4grFWE8tjzKCGtcfHGYgUrEo0oVPSwUyPwmrDhLUdHn1ZShHIy
         2QHTJ5jWUHffyVJwxR8/GEP8lswRpPgAUDGO2efAEn2y0DbA1vniWnGRbccSxwjcWNZj
         FIGkv8uZycQ53iEBWGx0ay67j8jdVhNn2t9L+QYdZl+fdmBytjTuXjtk//WdxjaFZJ0f
         IIesms7iJsWLHuz0ByKqdBydEepEn8fCUmO8+qRnZc/zj6ICwx+lANnNzf2NiWgvs+TL
         Q9Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WfAD44X1BzculJPRKgkBzDtXvs53Y6udmLphUq85RKM=;
        fh=ct204Mk0nXAExnklDBIo3LYHhJb2hwpNZDZ4tviQpqA=;
        b=RlpqbhMaXhyn6oxqmEJ3AfUhHponuRd3BTFSLt+JPs6OaAvEpBVPp2fhTWRdTzEM1Q
         AC6c+YmBYoFRWC5u+Kmu3DJrE5JIjj0gUKV1F+ZqGPRPM2O0Moc2l+xCaOeI8NN7N5vh
         qcSc+23KuAnmwrJZBZNmerBt2AfyER7bezbXlwq+3R/ZJCHuHCzVD0AtVkuGtlEVjM2g
         wdIt1XCaC2PYuLvL6ProxfK/NqTOLQ78U0UlshgiZrgcIntF5REahRL0+tO933cmnMMB
         GaFNVo/6uspupgeVJWK2HjGLfnCnnqIZKfIw/M7+u3xVgthJsiiLjwHEflXLRFoFr0Wi
         GLsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783684036; x=1784288836; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WfAD44X1BzculJPRKgkBzDtXvs53Y6udmLphUq85RKM=;
        b=UODODA5DKC4lml4cIcTDcNp3+I37NijZ2IGkJIdlwSOPrkbAQprAkp888XJdGVNbsN
         vM01jAYIeiXxva2BleXJsgiTLrFDyeKh7WxkOyQ7on0v7MHLuadTGwVLgJjL5j39yIB6
         XpEeg0VsrQdRIITEXibaG9KjtDFdyX3owx9z1+cwJIds81WRW2Yk8LINyM6/ZK9TlQaq
         QUQAL5PNtKIUlTrvmWV4y0a4/NHKBbIti3ZQfiqnIHhl9uFfphWl29gpHAaSLIVx4nx2
         VQyL9WmPjBGLGUIo51Cj1zCIvpCAYumTv9H3CLOC7LFDZNUGT/W7AFFJYI6tRtpRSu1w
         G8TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783684036; x=1784288836;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WfAD44X1BzculJPRKgkBzDtXvs53Y6udmLphUq85RKM=;
        b=A9pXSprZQriY2q1G2FpAqkyblu6dUsBWlYpmuVdO4GwcYDFeDFJQ5meuH1AkGTSu1z
         z9CvJqHN4RVRb9pqS0p308QD7cJqWx63Xc5fLnJlUEI71tCt+ZmzAM89iriYrU0Pnc2Y
         odWwgVfXE6keMBbwW0JhPex1XGk/EQEejWDKsj87/YmgW57jk10eXJ5S4F4Rdk8LyLy1
         56MPmySRv6YSZcGEleIQCMAm0/VqkaxdVKhyBY5cTYp6msIyJAQRaKzVy1mzkoVIFNh8
         p0VEM2HcY/JyzYtZSPXeFX28JW+yF32Ewo3710a+DMYxttGrIpzfpeVeSx4uvzQqcUW6
         D6Lg==
X-Forwarded-Encrypted: i=1; AHgh+Rot7VEGC+o/aeZnDWPFF8Gffyv+uMeEfrarJn3+sKj8x3CO6kBzwF7NyRSssyRsMsmQTGnrOSxhOrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjWkMRKNYTGSookBIkzxVv2yQT9VtRMyY9pmhOvLWCFlLi0Bni
	FM45JwAbZr8j2PUwYJiiahRkAm59vi+GKu3iSPq8Zu5BRmi/lXwqr/WVrMcJPJSlI8YclRldt3H
	lPCriBOmGlDgWOwhDC0k2RASCHdKABAI=
X-Gm-Gg: AfdE7ckFUIz2PuHWp6SKAxO0iE4GoTm+CXZuexH4QydeI4lPdy5RPBXMyLsp3aAJMNj
	DY2zci6AJiuWtzNt6ilA5EioFWg5DtDInXFP+6AEimZiN/SM4pKPnAoGDwKz6U7qmVrbAuvpVGO
	e6HnDWhpcOARXrt7BYCN6QyWE/QODK1hmVrXAuo9axWLjnt6Jr7nykCcBqWEO6jtGn8wagaRHNv
	cmz8S/PzsTnsa9Qj7go2v/bnKYNtCiMJPFPu9gZHuvC5EE/WqA2c5T5/wQz8YPsoKijxAxnkGen
	/zSgMjwPdytG5bdyi6FuFmYGgPoJpE538yd/kJKhMIPp+fFyW/sx/8ys0OajB2I4+wXsJQ==
X-Received: by 2002:a05:6512:10cf:b0:5ae:b130:1e1 with SMTP id
 2adb3069b0e04-5b011444080mr2821194e87.28.1783684036068; Fri, 10 Jul 2026
 04:47:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626-pwm-loongson-fix-v2-0-5492db953879@gmail.com>
 <20260626-pwm-loongson-fix-v2-1-5492db953879@gmail.com> <aktdkn-NcQt7J1YS@monoceros>
 <CAJhJPsVffZLTzXyA41rxm=A54sZhROVg-+K-gWo1KEzuKGv15w@mail.gmail.com> <alCIB5nGfYlEZsMg@monoceros>
In-Reply-To: <alCIB5nGfYlEZsMg@monoceros>
From: Keguang Zhang <keguang.zhang@gmail.com>
Date: Fri, 10 Jul 2026 19:46:38 +0800
X-Gm-Features: AUfX_mxXwG-AqhIKVwFzB91HdQlthD3Wluqyqdx-fOUZeZ9hdjf8BWYvKbGC-cY
Message-ID: <CAJhJPsXf+XoKhMZSjwziRmpj+_BKKqJhsbACd6ViYJPUXw45Kg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] pwm: loongson: Fix low pulse buffer register handling
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, linux-pwm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9687-lists,linux-pwm=lfdr.de];
	FORGED_SENDER(0.00)[keguangzhang@gmail.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ukleinek@kernel.org,m:zhoubinbin@loongson.cn,m:linux-pwm@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[keguangzhang@gmail.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 952BA73A728

On Fri, Jul 10, 2026 at 1:52=E2=80=AFPM Uwe Kleine-K=C3=B6nig <ukleinek@ker=
nel.org> wrote:
>
> Hello,
>
> On Thu, Jul 09, 2026 at 03:25:38PM +0800, Keguang Zhang wrote:
> > On Mon, Jul 6, 2026 at 4:00=E2=80=AFPM Uwe Kleine-K=C3=B6nig <ukleinek@=
kernel.org> wrote:
> > > > -     /* duty & period have a max of 2^32, so we can't overflow */
> > > > -     state->duty_cycle =3D DIV64_U64_ROUND_UP((u64)duty * NSEC_PER=
_SEC, ddata->clk_rate);
> > > > +     /* low & period have a max of 2^32, so we can't overflow */
> > > > +     state->duty_cycle =3D DIV64_U64_ROUND_UP((u64)(period - low) =
* NSEC_PER_SEC, ddata->clk_rate);
> > >
> > > What happens if low > period?
> >
> > pwm_state_valid() in drivers/pwm/core.c ensures that duty_cycle <=3D
> > period before the framework calls the driver's .apply(). Since this
> > driver always programs low =3D period - duty, low cannot exceed period
> > when configured through the PWM framework.
>
> But this is only the case when .get_state() is called after the hardware
> was programmed by Linux. The function should also work for the state the
> bootloader left the hardware in.
>

Thanks for the clarification. I'll handle the low > period case in the
next version.

> Best regards
> Uwe



--=20
Best regards,

Keguang Zhang

