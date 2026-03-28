Return-Path: <linux-pwm+bounces-8399-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHo9Kl7dx2lKdwUAu9opvQ
	(envelope-from <linux-pwm+bounces-8399-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sat, 28 Mar 2026 14:53:34 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E65634E966
	for <lists+linux-pwm@lfdr.de>; Sat, 28 Mar 2026 14:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F147D301117D
	for <lists+linux-pwm@lfdr.de>; Sat, 28 Mar 2026 13:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212B02F83B7;
	Sat, 28 Mar 2026 13:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMKO5gvp"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEBE26ED33
	for <linux-pwm@vger.kernel.org>; Sat, 28 Mar 2026 13:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774706012; cv=pass; b=LqltevIKpeX6krNkaK6JtsIGUcaqk3EXdaONPuSKE2s6HqLKm2TQBiJsoy4mtwGCr7+UawfURj3mmBtNn/O3TTu+o95bsX4pj4VfEhxDI9Nr1S4Fquo/N+enZ636EEB8bP3FhK8owO2YGObkfxjk+rV7fttWFc+XpsPKQI+AUnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774706012; c=relaxed/simple;
	bh=VAAaLa1sKBGqgetOeHXl/eZDgOECB6DkSmQX1X2/W1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mjmUcjlu7C8P564em/pq5EAEdenw91c5Q8imHuglJyREP8sgDbjrindsot86PTRYOCPRMqw1nViKznOMjHi5lRM5JlhCGAazvi87qP3jxeZdBt/yeeO+7oSCW737Sj2n3owCGAaA37n+ZeqcOd2VwENB55R/0Om/O4XXmfEIyTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hMKO5gvp; arc=pass smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2bd5658b901so108303eec.3
        for <linux-pwm@vger.kernel.org>; Sat, 28 Mar 2026 06:53:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774706010; cv=none;
        d=google.com; s=arc-20240605;
        b=B15BzkmDAErtv6aVXfIjegly9Dglqh5jmUO7pM7Mlck50p5SeQ3wfX5blZbdmIAsLA
         ebm/F4gpyGy+BaVZxVa0gkYDqVaaxC0HrlX1HaJojoLK/Z/ndMj+rNAMDEjlb3Fx28W4
         aLob0E21uV7dL9F5v6Ck5vgbXFjc7y+wOcpdcqPWse9sK5m3SaEUBa8mPo9KW0WYlYiZ
         JBWThIUT5SUWi6gj1OJ8OOmAZMZsaiyl4z2rHjmmJqzYK8C29kL6jmCT0aeZMaeP5BXP
         BwZQUv7a3qBSETHPoANd2Mtmn8hdHHauTCt7+KAQiMGrfeWcYK/d8TW1TNl9uajt8sFU
         tpeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VAAaLa1sKBGqgetOeHXl/eZDgOECB6DkSmQX1X2/W1s=;
        fh=y4kGNQMAAvoG+nXCFES5iGvb7pc2FXt1dO2AWATHoyk=;
        b=KrUT9BXL+w7qxpLh02Qwlloh6UEdFn5PHTtYueRsx5pWO4Wp3H5ujWJvIe3N5Er1fD
         iONwU0dF7JkfesAflQu8CTo6vwxEIGsJ+e1xijYZuvmpPZc07lJU8TmcNmHtvJJetXjX
         +BH+FNC+DwrDjvTb2sRVNVoqxmjh/fZU5aVaw1vbqTITeMZjRvcoGZS0l3Et6PvNabot
         I8S+QwacF/oQqBVuqWeg1mx4GQsJSGHYYPCXDTH7GVDcyOBXsSpkIf55xzhtAlx9OnnB
         KBjq/9WXlPggeZfruQtNW5/kkPUX9AD6RbkOs9vCA2cazOGyy8eAYBZdfSUOhnRT70Ko
         8vFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774706010; x=1775310810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VAAaLa1sKBGqgetOeHXl/eZDgOECB6DkSmQX1X2/W1s=;
        b=hMKO5gvpa+q+I7DLhA7WSWMS6G8j+7Rrof6D1HXkcTIEjAq2Ispjj5JB9kjmumAQ0R
         C37ass2zSCBIbaa3B4/FnLJKUhJO8pmTI99S/TvE07lOTnoyT/yiuPMQkaqi+v+PSOGe
         GtVBNdUTrQg1vOQg+Ttkn+o/k7XIdhQoGNuZJk+bloT+2oElGy31AXDnzbPWQRoNvcNG
         pjPfeWCOARBrOGXq4fVEcJs/4X+bobYRbloDs+TLxqUV+wRmrCq2Q/LjPTe7R0hdMugP
         MbvVgdQ3LVMQb07IB7qq+FToCeoeahHTd/wweT+8mg/1A/UO3CEcYgZwML4oPtcsaWAy
         BcAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774706010; x=1775310810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VAAaLa1sKBGqgetOeHXl/eZDgOECB6DkSmQX1X2/W1s=;
        b=nCwM6OBbrshcwsVpGgJsWekxSnZttTWkMP1Tt/TqRI3aBhkdJ8SxEVjJ7yuBzQKGRP
         qtg7o13L3V2nCdA2W9ECH9YFvUC7BOyb43oY9nWPeViJo2RwJPpvru0tYHPx24O39vGA
         2OlTkN30oRv50haRgq6EEdubznGD1WNTb/0X7L7wDjaQmJqpsO89blCUiGqrVXdroPN2
         XOuQu8iufzVNiCCoMEKMDzSU4fYCtxBnC3mFJkabFQWchBlp5ltQSR/ggquX00A0fXKA
         ZaEkrlYNXGmdJPA1dU0Er+wOwKdZAV8yQNwwgrhr7OePI14jjrTlft552eJZ/KDGsy9E
         3WRw==
X-Forwarded-Encrypted: i=1; AJvYcCU7YFamfVBO/cL3lyiIDfeJEma15QRgAueEIMOi7x0pjajU1EwPXY1996MmqH26S3B//iqNpOkSYXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiFMxsG+7Btr6xXgunwWRbdD6wZKHnfmavwtZ6GshkGUtVej1m
	8RrQpbqi21sdpeeoIel+Dhc1+tsPCADdYzdr/RYU6I0bFrMv75x13ZpCe33Q0/iyANy88XbaM9j
	gvPHCR7KJVSMKWC3hnvnRIOJdrg6C2dI=
X-Gm-Gg: ATEYQzzGWXjaTDInD7kBd1Cli23lddpnfKZJk8hwdyh4RN7h+1pgRU3ZZuPN99Adcxp
	GaLuim7tZX9J6lSHzDRDZPt1hJxL5rZovFUFOcwDy3vUB6hFl0tb+44tH6L1pvsB96EqgFZB6R9
	Ynm5W1dPJMrUq9RCWUvHIEkbyrJXYIvJvzL3k0a5E+90li3aAa16QvNz5Tmvbp0D0Xy1RskMDKL
	wz/ED6311HCCOOe4h3LgPw49wkdc/YN7Q/+calJqmy8sXvFbG6U0Xb3MMimSpycEt+ZYm/3e8rg
	9ahtdYvYzq5W/BfzpkG08O75lPWW5A5SackLeSaDIYOCIMtudZbaxp5plr6lcjb9LLwA4B2i8zD
	vZQDCXqvdbN9Q4WWKxAQ4wXo=
X-Received: by 2002:a05:7301:9f0a:b0:2c4:76a3:be04 with SMTP id
 5a478bee46e88-2c476b31c65mr246246eec.0.1774706009912; Sat, 28 Mar 2026
 06:53:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121183719.71659-1-ojeda@kernel.org> <aYmgjEWaLrdsubKM@monoceros>
In-Reply-To: <aYmgjEWaLrdsubKM@monoceros>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 28 Mar 2026 14:53:17 +0100
X-Gm-Features: AQROBzA8MjUBXYFRm6h4gop3ycXvMcobXQ3-8BaNpAO4VrnoBIXKMybPKp-xm_s
Message-ID: <CANiq72kk_UJVNbQ3aKuV4_LPFm-a0xjZqZyk57ZpkHp8yX8jzQ@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8399-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[kernel.org,samsung.com,redhat.com,lists.infradead.org,gmail.com,garyguo.net,protonmail.com,google.com,umich.edu,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,baylibre.com:email]
X-Rspamd-Queue-Id: 4E65634E966
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Feb 9, 2026 at 9:56=E2=80=AFAM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
>
> Looks good to me. I'll wait for Michal to add his blessing and then when
> picking it up tend to drop the Fixes line. Or do we also care about
> CLIPPY-cleanness in stable?

Do you plan on picking this one up? Michal already reviewed it.

Thanks!

Cheers,
Miguel

