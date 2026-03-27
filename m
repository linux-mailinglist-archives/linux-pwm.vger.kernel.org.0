Return-Path: <linux-pwm+bounces-8395-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHB/Cva3xmnoNwUAu9opvQ
	(envelope-from <linux-pwm+bounces-8395-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Mar 2026 18:01:42 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3B9347FBC
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Mar 2026 18:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C571530CB8DA
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Mar 2026 16:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D3E35AC0B;
	Fri, 27 Mar 2026 16:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M+lM8qSm";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kkWJRpFa"
X-Original-To: linux-pwm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCD122B8B6
	for <linux-pwm@vger.kernel.org>; Fri, 27 Mar 2026 16:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774630480; cv=pass; b=KvDdvjx8+BTlVTGlOeuyPbE7yyVKDWu7BO0GrbjIrkmA3XrGZjNMWZvyDhpd0pESzhwaLOdKY73CEkQ75Fq1igvDjyEbuUAW8E1PJqoA5lqTz8SIHWD2lqQLLZpz+Dtw13aAxJKR17aV8H1vU5vkzRbE+p9BX7UgDIriHXIKhn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774630480; c=relaxed/simple;
	bh=AA7FXil+Trih5c1d9kWVytFuGXphEJXf1NURtb9SB3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gOTJ4DIUU6duC4J/bx54RTc9buaKUI8FYndviSZmD9BxF30kZS+6cjK8WO6qP4U0jw4lRJNisXxOP1evwFlW3i1ZzM802JN8E/tMZOeO2KqPCRvR0J/7F95zoEBBxUkiTJSQ3mPBasvlJGSU6MfUR+T8QiMBy+hfqy+0MqAV/ug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M+lM8qSm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kkWJRpFa; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774630478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AA7FXil+Trih5c1d9kWVytFuGXphEJXf1NURtb9SB3E=;
	b=M+lM8qSm06aaM2HXue/gJ+V2Twiq0p5rLC3hXuni8aajFX1Gep64kDG8y741Gwuva60l49
	6kJAWv5LfVjpmxOuUB5TbrP+FEBJ+IjvMOMXO5h6SdB2fsqX3j+I6cvaEbk1sDPKKqjRuA
	Q2yvUtceEkvg/4B3HikzSJCPoLYJOnM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-9wBFo4hINTebNQqzzQfKXQ-1; Fri, 27 Mar 2026 12:54:37 -0400
X-MC-Unique: 9wBFo4hINTebNQqzzQfKXQ-1
X-Mimecast-MFC-AGG-ID: 9wBFo4hINTebNQqzzQfKXQ_1774630476
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b934e96af9dso332610266b.3
        for <linux-pwm@vger.kernel.org>; Fri, 27 Mar 2026 09:54:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774630476; cv=none;
        d=google.com; s=arc-20240605;
        b=Eh4RpE3mQlZuUsExiKEJLV+YboGX8ONwdK3G1HDPoBCg1NxiL5x9LlHg7Aq2MkUQU1
         03bK3WHKBRJ4gT/RhCtqrVNCf3YAcELSwvK3HFII0SlO8KP7EBUOYsYKUvVvJwvKhFof
         DbkAdxpClrMnL0kJk/+FeIBw2c4FW4wt7NgjcVI3sIVD5zPQIi0uTgM8x4AyN0pdlBbl
         mPhXq2CK8wvb7TxD6FicJYw6kXGLkUmDvyiWhjdOpwY5e7xWtj6e5BvhlRsYpkKfUxfT
         NEMNPeu0Nhkne6sBS+9ULPDma1h11YJGNsLw9Ro7AtILnwqtUg+I2iTxVlHv4QXLTfzJ
         5WgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AA7FXil+Trih5c1d9kWVytFuGXphEJXf1NURtb9SB3E=;
        fh=6JsnsZ+hDM7MOUAxEnZx6wLjVxJZf/6cCQCmpNzxc9I=;
        b=QBwcS32RbRHYMJEbZRS4bAQbkqtOmNksqdMxKOWtoWXztM92N+KRocKWA9v55Oqoab
         ZVgQGMo8hcOLiZxLWhiJAo/grZAXOXBsNmQVBIePKEf+km/28mf+zijInZxobZ6axLXp
         Y5JrCPF+HDze8UQ8byIwAwAW30N7tI7ZgHFwDJMEOh9eD2V/vOaOo7ulDPLJRbpgwW8b
         6qekKYBujnZRDDTyrssKZeBmm1ABtYc69FVKo1FVrggXGV8RcHI6Gax2eRHEZX+zaxzd
         yNsUJAlU9YpOZk0h655zg9/HftkjB5FQk/zXf2bQL/vjn4HR3BwMcEvyp9hNuiJDjHvr
         0gwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774630476; x=1775235276; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AA7FXil+Trih5c1d9kWVytFuGXphEJXf1NURtb9SB3E=;
        b=kkWJRpFaLyDrk3WoOy0rPbhglWs/Ir/9/QatWq7O/Jg4mmx6vLZiw2I5NTKWMYSYtA
         D0RkgtgU2x0yuaQ7SLApFMghsSo1nAtQF9KffUV9E8AhQt4QMlKxqgGBE4ks4R6XMEQ5
         7P+0XrC41+C3Hg36gdqdx6GDto+ClKnwPdNC7NIM2aTswQ7UTuEvBWWdDmRgQc9JidIF
         HQJC/7l65+6FeJxrC/CzRoPxN66RRD5f4IuSvH30BSg7qaBV3E0rTLvT0/dJkIHUZvTM
         Sru9rWyG9+uuy2CMjOyw/H9mrBzDjf+v6XKKYvAPlJ6wsPXUWcYU8zidQPSQYz8rEiXw
         7knQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774630476; x=1775235276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AA7FXil+Trih5c1d9kWVytFuGXphEJXf1NURtb9SB3E=;
        b=AMenNQRGAv8uAX44xy/cCUdJ2CVzn6/CdIqSwl7O6EpeHrF8pqcK/DrWrDC6vOLiNH
         Jo+1idUCFzU+RuSnvS7ZbYRoiGYGW9lbDDE0uOLSR21aYJ7Vtl7//YAljOJL45w1iEjc
         K94Act3Wv1888xRUsPr1Y88+7jj4bbdgJTgLbd7maxjUREMCV1dPF3ol26OPQLiHdHaK
         cv/XE3HwPDK4qrmJvZ0ZCFQGE8ND3M61CoEGGEmToBl3gx1FlZK+wuETPBxZdsclGzft
         OuoHFIMjwTqEb6KYPZYTzV/dNpCuE8hbqpaY2WnmXyR8g1wVh4fOHU9TJNHeZhce2CMx
         z/Yg==
X-Forwarded-Encrypted: i=1; AJvYcCWP9l5TSxkScYCM7UUzZtVGwic2kVAOulpDXuXYurIBGCHa3kHlM5KmCINcYI/33EkiynDKHb0ZELg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHfPSdogJCqdmTkVQh+jGCV3k9nURmvH/z8HV9uy0sxsi/Xo3m
	qd/xgDHhV/rvMKo+S353m6nWjyloOkVMMt+t5jbh77TNkSdF/m4lMYH5Nndg+9nBY39io9MejE6
	mwKYIdfv9zAoRiOYFmWOBaI8nQw186zRgb//jVSP9erNWhlgOfzeKvLBtjio0qWG/4qo4AhUIj6
	OWLS3ALiX6U7ejOnHYgTZGmjNAMNgxzmfIRpzz
X-Gm-Gg: ATEYQzzcCXRjQT1cy09Iq6ziShNhY5Acwj3JSF6pJJ70dm/4ouCQW19jz57sbxLS3wy
	9Onyrg+O4W4343S2xJnbumxiOgmK83P50+dV09DY14zUxVEAJHg616bsnYKXouY8Wai08nrD6xC
	LekM81JB8UGgWKRtUGZBFP0HkBKT4tvhx4I0GVnVh/PdIbUMSp7BmvtZdFTlSRO/K7/bVyEawqQ
	/PcWA==
X-Received: by 2002:a17:907:c294:b0:b96:e11e:97a3 with SMTP id a640c23a62f3a-b9b509438cdmr207734766b.51.1774630476017;
        Fri, 27 Mar 2026 09:54:36 -0700 (PDT)
X-Received: by 2002:a17:907:c294:b0:b96:e11e:97a3 with SMTP id
 a640c23a62f3a-b9b509438cdmr207731766b.51.1774630475513; Fri, 27 Mar 2026
 09:54:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223-clk-send-sync-v5-0-181bf2f35652@google.com>
 <DH7L09UFWGTK.2MT0OTWH1DUV4@kernel.org> <20260321-awesome-hot-kingfisher-5d9f55@houat>
 <CABx5tqJvOFEzmadeXpDxSUjkghviqtP0jo+kzSB5X6u_P_j2ig@mail.gmail.com>
 <CABx5tqL+G9i1ZW7i5AHaTqUFTVRDmBvP=RycUdwjG-GOp4uzBA@mail.gmail.com>
 <CANiq72=M3H-06L7udG_LqTwLykZkAjfy2d5NXQZn5TYRJ+N37w@mail.gmail.com>
 <CABx5tq+TdGvL+SCUe87qWFgeAq-1Zf5w63jn2hLe9+YTyz4sNw@mail.gmail.com> <DHDOH1FXTIZT.1QKZIPZ73YNLI@kernel.org>
In-Reply-To: <DHDOH1FXTIZT.1QKZIPZ73YNLI@kernel.org>
From: Brian Masney <bmasney@redhat.com>
Date: Fri, 27 Mar 2026 12:54:24 -0400
X-Gm-Features: AQROBzBbM13XF9Lw32GUQ1TlyrNM8BNb-Fkj0IVXkv6U0HfbzJXabBJAUaFVI5s
Message-ID: <CABx5tqJho=k88A1L0neVeaiYCXpLsc7UjzGSgAug73ZC_amYag@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Implement Send and Sync for clk
To: Danilo Krummrich <dakr@kernel.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Maxime Ripard <mripard@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Michael Turquette <mturquette@baylibre.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Drew Fustini <fustini@kernel.org>, 
	Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Michal Wilczynski <m.wilczynski@samsung.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Daniel Almeida <daniel.almeida@collabora.com>, 
	linux-clk@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-pwm@vger.kernel.org, Boqun Feng <boqun@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8395-lists,linux-pwm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,google.com,baylibre.com,linux.intel.com,redhat.com,samsung.com,linaro.org,garyguo.net,protonmail.com,umich.edu,collabora.com,vger.kernel.org,lists.freedesktop.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bmasney@redhat.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7D3B9347FBC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 11:42=E2=80=AFAM Danilo Krummrich <dakr@kernel.org>=
 wrote:
> On Fri Mar 27, 2026 at 4:17 PM CET, Brian Masney wrote:
> > I am not a clk maintainer, so I can't leave an Acked-by for you to
> > pick this up unfortunately. I've been quite active in the clk
> > subsystem though the last 6 months or so.
>
> I'm not involved in the CLK subsystem, but maybe it would be a good chanc=
e to
> offer stepping up as co-maintainer (also given that Michael seems to be i=
nactive
> for a couple of years now). :)

I mentioned to Stephen at the last LPC in Tokyo that I am interested
in becoming a clk co-maintainer. I've sent him some git pulls for some
of my work the last few development cycles, and he's pulled them. For
this development cycle, I collected up some patches from others that I
feel are ready, however I didn't hear back from Stephen yet:

https://lore.kernel.org/linux-clk/abLV9vjYxXsKciHW@redhat.com/

He separately pulled some of that work via the posted patches into
clk-next this week. I don't know if there was something he didn't like
in my git pull.

To be honest, I initially helped with reviews trying to free up time
for him to give feedback about my work to address some long-standing
issues related to clk scaling that affect DRM and sound:

https://lore.kernel.org/linux-clk/20260323-clk-scaling-v7-0-8e7193dc9405@re=
dhat.com/
The kunit tests in patch 2 and 4 clearly show the issues. (I'm working
on some fixes to this series right now based on feedback from
Sashiko.)

I've become more interested in the clk subsystem as I learn more about
it. There are other improvements that I am willing to make to the clk
subsystem, however the current situation has been quite challenging to
be honest. I will help with the linux-clk subsystem for the long term
if there is the possibility of me eventually becoming a co-maintainer.
Stephen can have veto power over what goes in.

Brian


