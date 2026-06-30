Return-Path: <linux-pwm+bounces-9483-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GpWBG2SAQ2qeZQoAu9opvQ
	(envelope-from <linux-pwm+bounces-9483-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Jun 2026 10:37:56 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D28426E1B96
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Jun 2026 10:37:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=P4QDKeSM;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9483-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9483-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97682301F5D3
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Jun 2026 08:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F051E2BE63F;
	Tue, 30 Jun 2026 08:35:15 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22C21BD9D0
	for <linux-pwm@vger.kernel.org>; Tue, 30 Jun 2026 08:35:14 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782808515; cv=pass; b=kOmtzE1L42FtASnqiu5+cpv2DdApoXtaAl9ItP2yv62T1NZdwTg+9qOmGcwbhTEPWHFpP51sk81cN6VmP726AJynYecnXlC3XAxap9qL+jZGEq28/gt4ojis3XnsF6cMkHUR1BPDPhA5iU7s1t2lVIMMPsX/jckpGDhH3XmK2lI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782808515; c=relaxed/simple;
	bh=12uAIaSCl7tiswRNJqqBaN64Jz/2PQBPhlMgm7mCoFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a2R7e6QzsYiVQ4J1APg8THHdgEYZ+I/RthBDqp6/D+/s3dNEkg3mejJA/HpI/HcQg4JsESgm0+qTiSd2fvulHcSjdmU9rDvsaeuMMB3v4sJdEraeYgf9QkPBhQj1JTNvyggz3evoj8VYUIBt4h9PoqRMh15ZPVB49oCd3WuTEYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P4QDKeSM; arc=pass smtp.client-ip=74.125.82.177
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-30c5912314fso555349eec.2
        for <linux-pwm@vger.kernel.org>; Tue, 30 Jun 2026 01:35:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782808514; cv=none;
        d=google.com; s=arc-20260327;
        b=EfRM7+qURoNhPdHwS5zJeIYFmCPl1rIKnfLOw0z/SoZl0Qba6ekZBI6udPXtjqcueB
         uje2GPphABLh4wOgGYgkak6r8K/sbQw2qn4DTyDy+x3MieA4xMiujj9bMHQTdU31N3KL
         P9NbrwTbWb4jZ1DvDlXEEF/25eRz84P4tzDEhepSiVd+C+adgdeUHIUbAUS1DdxY3X2P
         /MYINvi7gNACZGRX35tKfwFUBaP/QEMYYkXmsZ3OXX7olA7gHFgSrQHlGagEIkddtvw4
         H1UCmYtg6qSBDabbGqHhGEpJzkrEgX/YhwukPwOZ44OCOFl8LivVzu67dl8bgRH2xppB
         TOOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2h4fg+PROtgYOgPDGjwjg1prtaKYRf+MRnb5H8GnFAw=;
        fh=OB7dirUWOKfhI+b4DDdgmVVYDJGiNbbA4CRn8+gxxJg=;
        b=pcPZ/DQUVdYUIld3sTyj24VUiXDOQei8cn3OBkFvRqymC7Wh9WvLntEn7Dtnr4+w0W
         14gXhy3/EEFaOB8JatKF1THqQUETulFVb6S8GUyWGSYLeWAvYYjQC5ndw7uWR4vyo6iA
         KhdEjB4618oemEcjldLPxKRfgEEgshSI6rSEO+pFWFdXBE6+2feS8zzdS8g4hozppmLH
         jPcbe93kynW3rU4/nNAGc/QTCXZihdoGyxCUzUK5uBiV5wbBaBR5Quu5FSCzqln1dZcJ
         tbR+du1zFAkIJKRpEwEeupSY6RnRnecq0L1kstqHQbdKIGRaTkuEuqtGb5cUKDMBLpzn
         z/bw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782808514; x=1783413314; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2h4fg+PROtgYOgPDGjwjg1prtaKYRf+MRnb5H8GnFAw=;
        b=P4QDKeSMKLnfVsDrpWCuEmR+fde0eSYT8JQqFhe7xLiugA+IX+ZEepZDsU6I5Ie6jm
         EtCDCgp7ZUpLvZdZ9CeeHs1gUu0FxMROHIvFtqAoQDLzY4WLKVd+sF0mn1+zSJcaOOg7
         ivbtAQ3UbteWlBQOZntGY9QsskxDj5hlMxFvEVEvo4HBZvZsK14n0N8BCitTpGtn20mb
         QA2/hDVc2OLBIH9W3JVORw9oy7kYaxNwQxRz/mq6Pak487EKo1e1i7J5CyPThcjxMTpL
         uBwhyWHKVQUOpS4s/mkDiT5cs0YZI553d1UZiED4mLQC2v3AAQ2O+HmyAr+DDIx3cXgg
         pdPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782808514; x=1783413314;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2h4fg+PROtgYOgPDGjwjg1prtaKYRf+MRnb5H8GnFAw=;
        b=D3R8TvpPET9y00KagM41V0+X4wMZoHOiz/aH9c0G8ewsN9a7mQdnk+H8PtLE2csp3W
         f5OOpf0D/PDJ9sAnEXiWQQ2bWPS7D6r4Tqp7EJKVAVMlOejDl+a9u6STniENKEcJ2HhW
         ti9Hw4IJnDiSkM2yL8/08aS5F6mL2JjhXSShRF9/tbrZeBDTVtmU/wc98SsoBriy9gdh
         OCJTVdQhYslE/i9GA9/E/sdZk1rtzfRld4jDZdLpQl9jLCwy/1XL5+o2vwkc555rGqy9
         8KCYbASmbQWXML1wv+IW7mxW4Oih1rYmT/j+9HTvqoQgHUPn1APfw/p+VE9NXgWWaZg3
         F2Xw==
X-Forwarded-Encrypted: i=1; AHgh+RpiVsXEumHpA7YtKPtiikItBABLUt9lyv5uF7ujCRd0xNbXw4x9c3s1YaK1tQnvr/r7aifAiOnpkuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdx/juffj4Ki1E2Rlw7oLLBTGMf/bfuc42BQd8gWFDYm/QJ3Yi
	QPFWuwQYzGnIJiJr5b1NhUa5aYdKT7dFjyIXHpltu1N+c5QfZdftTfSzHjkbUF7USrDKJwjfh38
	1RryTp+DmryJWHSaVqhPvIjoX19RzuiA=
X-Gm-Gg: AfdE7ckPU2d4KSROxv/nd/njATFHbm63rkWuJbErlv3MzZISb2ufOuBI+jW1kp3Y7Cb
	fJseuTqrhVkTZ9+Swtu9d32ufrD7LJmOBhMzjQpIayiuizH0u7Fw2jIFLyPFYZDJQc/dTGjMFU3
	8Y59sXWmp/eaGOmQgWkrBo/cnJY/e5qU5xmk/ja0bc3IM9zZ4AOsXUb9NGySmPYK8sUBo+HVMx3
	PqdOuQRpsCvDN3trveErZkZU7Vtr79qfuTDxwOx7ObaURDZGyuLw0IdIJzkwKR/eGqzf7KiyWZu
	T9kL2Igj3dZfFzw26LgUMq1XWpvUttuq+6w9j/wAATZRgoIA3dKmqvmI4vMwsvEidkLUsv/HmJV
	TEBv6jWasTjgU
X-Received: by 2002:a05:7300:6ca1:b0:30e:dda8:e0ba with SMTP id
 5a478bee46e88-30ee150954cmr1003565eec.6.1782808513710; Tue, 30 Jun 2026
 01:35:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260628-b4-rust-vertical-imports-v1-0-98bc71d4810b@gurudas.dev>
 <20260628-b4-rust-vertical-imports-v1-3-98bc71d4810b@gurudas.dev> <f0ed588a-6cfb-4079-a2fe-7c14f1b42727@oss.qualcomm.com>
In-Reply-To: <f0ed588a-6cfb-4079-a2fe-7c14f1b42727@oss.qualcomm.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 30 Jun 2026 10:35:00 +0200
X-Gm-Features: AVVi8CdhtqV-BYuDJ7-_rhOqSdDxdGUExu9BuuQ1x0bjmiH_24JXcG_HI6rxurs
Message-ID: <CANiq72=SQK7pd-fj+4MOb=E6=R-DHCcLcuCvN=us2E5o7Rcy2A@mail.gmail.com>
Subject: Re: [PATCH 3/7] cpufreq: rcpufreq_dt: use vertical import style
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Cc: Guru Das Srinagesh <linux@gurudas.dev>, Miguel Ojeda <ojeda@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>, 
	Abdiel Janulgue <abdiel.janulgue@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Robin Murphy <robin.murphy@arm.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	Michal Wilczynski <m.wilczynski@samsung.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Jens Axboe <axboe@kernel.dk>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, driver-core@lists.linux.dev, 
	linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-block@vger.kernel.org, netdev@vger.kernel.org, 
	nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:zhongqiu.han@oss.qualcomm.com,m:linux@gurudas.dev,m:ojeda@kernel.org,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dakr@kernel.org,m:abdiel.janulgue@gmail.com,m:daniel.almeida@collabora.com,m:robin.murphy@arm.com,m:a.hindborg@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:aliceryhl@google.com,m:tmgross@umich.edu,m:tamird@kernel.org,m:acourbot@nvidia.com,m:work@onurozkan.dev,m:fustini@kernel.org,m:guoren@kernel.org,m:wefu@redhat.com,m:m.wilczynski@samsung.com,m:ukleinek@kernel.org,m:rafael@kernel.org,m:viresh.kumar@linaro.org,m:axboe@kernel.dk,m:fujita.tomonori@gmail.com,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:driver-core@lists.linux.dev,m:linux-riscv@lists.infradead.org,m:linux-pwm@vger.kernel.org,m:linux-pm@vger.kernel.org,m:linux-block@vger.k
 ernel.org,m:netdev@vger.kernel.org,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:abdieljanulgue@gmail.com,m:fujitatomonori@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-9483-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[miguelojedasandonis@gmail.com,linux-pwm@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[45];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,linux-pwm@vger.kernel.org];
	FREEMAIL_CC(0.00)[gurudas.dev,kernel.org,vger.kernel.org,gmail.com,collabora.com,arm.com,garyguo.net,protonmail.com,google.com,umich.edu,nvidia.com,onurozkan.dev,redhat.com,samsung.com,linaro.org,kernel.dk,lunn.ch,armlinux.org.uk,davemloft.net,ffwll.ch,lists.linux.dev,lists.infradead.org,lists.freedesktop.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D28426E1B96

On Mon, Jun 29, 2026 at 2:43=E2=80=AFPM Zhongqiu Han
<zhongqiu.han@oss.qualcomm.com> wrote:
>
> If the preferred style is to place each imported item on its own line,
> shouldn't imports such as
>
>      cpu, cpufreq,
>
> be formatted similarly as well?

Indeed, good eyes.

To do what we want, `rustfmt` needs the `//` at the end of that level
too (in the future, it will be without the `//`), i.e. the patch
probably passes `rustfmtcheck`, but it still needs to split that line
and add the other `//`.

Cheers,
Miguel

