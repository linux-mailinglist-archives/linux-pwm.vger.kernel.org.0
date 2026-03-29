Return-Path: <linux-pwm+bounces-8403-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Aa9CdAUyWl9uQUAu9opvQ
	(envelope-from <linux-pwm+bounces-8403-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sun, 29 Mar 2026 14:02:24 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D978351E17
	for <lists+linux-pwm@lfdr.de>; Sun, 29 Mar 2026 14:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C885D30078DA
	for <lists+linux-pwm@lfdr.de>; Sun, 29 Mar 2026 12:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63D92C3251;
	Sun, 29 Mar 2026 12:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FRFbsGpt"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8733D2FF170
	for <linux-pwm@vger.kernel.org>; Sun, 29 Mar 2026 12:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774785707; cv=pass; b=nWf0YubmIQkbnYRdToLctEdJFLZ0riBfdoRnOWq1DT7VKnzDN9tVVVJIEtDVxzJzSiu7x4yvIAHSmHQc8H4tUXoOtk8BBJQtQVk/ie9yfTuUm/acVLYjNtiC6yQQwyh8NnkkzLtKlo/Oy65dOBKFj8jUoxO3Y7/mAg2LTknv3Ao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774785707; c=relaxed/simple;
	bh=S3RIszMlDvasNp1X3hRY0FzGfoJ2iZIuNPkp3yOr+9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=udKYMn8XEmkltvrha4pAtkLJh/nEGKomRA0geVilKUImn6qsRGRJrXbkDjF0t3R7Jd0D6XoNT/9TTQQoN1ZjYCVXNbdasvUR/wdBMA64caabOWPLnijFFKW5qm6AeYNH6vFKupeLGr514g757Q5V1Q0Gfd/X3I/jlJzgtilT6EM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FRFbsGpt; arc=pass smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2c5cf871adcso5470eec.1
        for <linux-pwm@vger.kernel.org>; Sun, 29 Mar 2026 05:01:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774785705; cv=none;
        d=google.com; s=arc-20240605;
        b=CgABprDZ6qLb22cRQmXfrsWyqoXWgrExA+BX9sgWs7/pL9YG/oi+EgZpMgihb86HWn
         5GMvI/C3OyB8hfKzFa9OiQ2jcXCwmDgIK8zeborOiHNPrfrG8zqUShJkDMlV9TZGYnYo
         NQyUn9dirWe0iQ/cyLxj3EkyFUcf7+3mFl/OJdqUs4KgpGVZFGChgmLLc9vemsepxoeG
         x+DGB7tO3i6a2mDrfNzPRJy6HOZWkRzlQTUB6+Oi0vAj1ebtUESfw58iCVPC7PXb4mAq
         TJPxXja93Z30wpzQ09dsuu7/4wMkLC03N4rmYEhB5gBOBfeFptR8bEKiyF4+iGxwGB0V
         IJrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=S3RIszMlDvasNp1X3hRY0FzGfoJ2iZIuNPkp3yOr+9Y=;
        fh=QH2r/XIejmiNO/6U+fUIxiwUaLho5rkTKmcXHIlw8fY=;
        b=IfsIZyTIkJOvalZ0qSUpQc5J+ZAdVUaI1yFWCgS9d3iuKBAnOk+oMsoUxLMI3LqB/0
         qqJDtPUNbe4bErekkmtuNddkbA5O1ALerqoWAJl4kR4wgNM3lSMwT4X8TWHh+/YoLA8v
         k22Ggb5h2rzuGPs+aoViqIaCE3AuDbrc8jdsDd92kPtix4X1Dsbv4Zx3h/N913tRwpno
         Gq1lKmL47/Ztf/jeXd4qpl2iAyi0bNm4ar4cJf1GNHrNIhaMy7m2zZVHNZueCE1dOTFd
         BuKV2fwhqbUfPbD3HgVFYz5bq97uiiyy+V10cc2broOLIf0QluRFVhaQtxHeiKSV0Bv2
         Fsrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774785705; x=1775390505; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S3RIszMlDvasNp1X3hRY0FzGfoJ2iZIuNPkp3yOr+9Y=;
        b=FRFbsGptb0y+Y4OQK8ph+GaN9JP8RzoASQF4wCQBKRiH47COKwAYQ+fUhLfMH8L8Sp
         GaAtXJUiT5Ofxdhc3ongtwOTtZSptVPNq4xUvy3b6G2JWWOq269jxFlwMcPpODM9itfQ
         /POBsZvmw5xfeN0klh1kVt2TQZWD5Fl3iO3EAwX+j7UzPNXa0RQELYtvuTvV0wIut774
         loqeWGCtSrm8o4xAA9vKexKE09CkcyPY3c2BMQB3KFwoAXspFgiHng4XiTWMH/RnBOfR
         8QTQtFpxzPT7VTRfxrJPTbZi++R06S/CXHHAczPrWeoBzwi2IgyQdsxoa/PfScv59GZb
         kypw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774785705; x=1775390505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S3RIszMlDvasNp1X3hRY0FzGfoJ2iZIuNPkp3yOr+9Y=;
        b=fLTEFXqEaKaWqsI6Bw8a0A3+tbOZyB2pGyFiF+VeotR0AjtLDVW0KimP3b55fg+AIa
         ufYoSbAtFS1AQpbnN6s69cIJsDZZ4of4wwns5CprYUp1NOFD3x4NWaKnICAq+Xklgn32
         Ol0/CwDSOJdWmH9bD4TLTSTWtBiN5Af4BmZ1haBf77gqhAtsQAXaav+PPQtHF24Vd4RG
         ZhyOwIm6rhVSVETp/p54Xh1+zeUssGremJCNgEn9WS1tRjDUfPyXvbL/8o5WGBS6La3R
         4BpymxKAt/iSdFoiuv4G/2IuOHssvuObAk1Yi/SQSqk/E9SCO7LxQtdViQSRIZNXOOXH
         YoZw==
X-Forwarded-Encrypted: i=1; AJvYcCVZ3kmU7KB1ScRyumxkOAFwdjuoUzGn547Oix0xtujfTnplU9hU0Cn88kodoKU5orxcbi5ITXF86JQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YynvYkft3zJt1UFn8ItRCEHQTwkv/k4QVZDivBKV5cfeh0zXi5b
	KLHz4qLQRObZnLeshyUk2SWDMnOc8tuqAhoLQOnnXb30RXTa84dzDW1Newt8/Eixih2U600OsvF
	KWjcr9RhHyybgtEhW5LjrG8E2D5YS+T4=
X-Gm-Gg: ATEYQzxsNv8E2XcQjYvHHruTUC6XIUaV8Gno/pql3qSHIxX+mLAyb0m55laRm11GUxy
	qo5AjXFXS+4Fz/hAGbF1yNG67yT2stDwERoak87JwhTlNTj5c1x+JzPI9HbRb3KjDRE8mgoI1sH
	1Euky2fQtSPJDtCCft/XlooLwMzKEu8SQ638PNNBfCwUyiA/LwEzYvDB+GiwblsYlE2+UzV8dRU
	RbSWilcKiJUtmNIHjaQgn38U3ppAFuSZw1WvGDxsxAC5rAcfDvQRQsMM4n6RON4QjR5r+Pjmq2w
	XYqAcz2tUlpgQAHuSgzMbWE9G9N0URyQLsy8kvfFEsa/jGIQ5PbRZHCNHWbgPDVeAdt3/RD+dXB
	5Cx/CyoT0R5+/FwQx7Kdx9xA=
X-Received: by 2002:a05:693c:3008:b0:2be:298c:a11 with SMTP id
 5a478bee46e88-2c185edf989mr2246595eec.3.1774785705374; Sun, 29 Mar 2026
 05:01:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121183719.71659-1-ojeda@kernel.org> <aYmgjEWaLrdsubKM@monoceros>
 <CANiq72kk_UJVNbQ3aKuV4_LPFm-a0xjZqZyk57ZpkHp8yX8jzQ@mail.gmail.com> <acjVGgDLnYAg1UAc@monoceros>
In-Reply-To: <acjVGgDLnYAg1UAc@monoceros>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 29 Mar 2026 14:01:32 +0200
X-Gm-Features: AQROBzC4ArywLCQm9oPk0DTBlwHpJWFCQIFrS7hccPJYCVsbdcvLs7tOCip51GM
Message-ID: <CANiq72kWu-XmFbYEGZFgTere14WjRS6JPS2vBPLB+hizi3tbAg@mail.gmail.com>
Subject: Re: [PATCH] pwm: th1520: fix `CLIPPY=1` warning
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Michal Wilczynski <m.wilczynski@samsung.com>, 
	Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	linux-riscv@lists.infradead.org, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	Mark Brown <broonie@kernel.org>, linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8403-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[kernel.org,samsung.com,redhat.com,lists.infradead.org,gmail.com,garyguo.net,protonmail.com,google.com,umich.edu,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ozlabs.org:url,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 7D978351E17
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 29, 2026 at 9:36=E2=80=AFAM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
>
> Hmm, I guess I missed that because that patch isn't on patchwork. I
> don't even find it in the list of patches that don't require action.
> (e.g.
> https://patchwork.ozlabs.org/project/linux-pwm/list/?submitter=3D83457&st=
ate=3D%2A&archive=3Dboth,
> or
> https://patchwork.ozlabs.org/project/linux-pwm/list/?series=3D&submitter=
=3D&state=3D*&q=3DCLIPPY%3D1&archive=3Dboth&delegate=3D
> )

Ah, yeah, I track things manually in a spreadsheet (which is a bit
insane... :), but this one was noticeable mostly because it appears in
CI runs etc.

> Applied with s/arithmatic/arithmetic/ in the commit log to
> https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/fo=
r-next
> now.

Thanks!

Cheers,
Miguel

