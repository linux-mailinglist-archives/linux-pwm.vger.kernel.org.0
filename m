Return-Path: <linux-pwm+bounces-9224-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id e2qWN3H5HmoJbQAAu9opvQ
	(envelope-from <linux-pwm+bounces-9224-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 02 Jun 2026 17:40:33 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 135A462FE0C
	for <lists+linux-pwm@lfdr.de>; Tue, 02 Jun 2026 17:40:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=BPTUKWy3;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9224-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9224-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 54201303740A
	for <lists+linux-pwm@lfdr.de>; Tue,  2 Jun 2026 15:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2F13EAC9A;
	Tue,  2 Jun 2026 15:12:12 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A541D187346
	for <linux-pwm@vger.kernel.org>; Tue,  2 Jun 2026 15:12:10 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780413132; cv=pass; b=OM6Y1+AhH/Nvk5g3xioeZohpZey1d0oWvPHpHvvUsSe7ojZh0a8IHqrXeLYkKx6jjIOGgPK9pRtT0kn6gRiNAMffCfGFfo8zVXCXAAqz/cSE6TZg9SV6eMTg2TQR35bBD0RK7iUARi0TVrkp+68F3jpWpVn+asQxasGHQ4JHdkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780413132; c=relaxed/simple;
	bh=uFPYloQT7XT6IfJNhJ/SAmsfhwQb5BmEaHuYH5X2XhI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=miglv6WwS3/YngxGkiPzYz9T9nIiVTp7c7ufSDl47k/Qr/jsXnrte7pj16rOb5NgTSjKvqPZz1KZ8d3w223N5KE+4Lcen9fYIeFLIJty18gV6LQeAyGJyb6sPWGSIAsqt7ccQ0Ijpp+IxnTfbL3zmgpFyn20EitsTuC3KBYJw2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BPTUKWy3; arc=pass smtp.client-ip=74.125.82.180
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-30741f821cfso92725eec.1
        for <linux-pwm@vger.kernel.org>; Tue, 02 Jun 2026 08:12:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780413130; cv=none;
        d=google.com; s=arc-20240605;
        b=HTl3fP6m11SRLG0k47XR1d7ZRrk1FcGdeQGGFtg8zGNn6wNXUvzhnvfRNEVvoOc/Go
         9aRmYg6viEoXbxUR/Tw5sE2PvYmd0gXqWhdWpyj4frBX7M05pJE+rwZKlEKRydPJmka4
         TdwzKVtnqaeusXW5NuPNMydQZgsnCeU/DSlBiXdzDc2B/0/6qJ1TkyAIo7sysugb5i44
         DHzB0cr62NOjo6wJaBHVdqCAYNONOHjKpZUpvuV4wvzYzZx4rjw6dyJW7RJZ82r8XBO0
         HOJhgyfPwD428nmwJ6qc6sCsZT5e5WYeskjnvzkBA5XeA7327HBdTHRsOsGqRJo9d0wk
         Y2LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YiJYeG2fCLjzF65IFEg2pHH+5NjWfuJTGzHlNysR1+U=;
        fh=aBGsj26+cnDjA7nglrc/51+Vgh0QvoVi69Grh9f+/Ow=;
        b=JKNP5xm6cko4RfwCQ9wYa0aSQskfN9KnCv4ba6XmicF3lTpYClijjCVF2QZn6mY5uB
         H3XmvmsIypBO3QBQp6wwzvHBRpSApVfzh2LKcHjypGfjcFIwpub14oXSZLRxit3a/mqU
         2E0dcwITA1q0U2Kefw3BBcjcuyfiUlNWCplGFmz9a/ELQ9/iB0b4q1bKMOd0SHRT3fuG
         dDWZ3GVNMCj1lM4Rbwr2FjZ63XcyHBQTug/EzNxvj1U2BRncXaSBuHTZG5kKVeZUrMjq
         jBwLWY93BNo+wSmtbmU2EzLUXdTjCxYi/CDvhDN7ijZL/2Mr1wsgWOz159UU0W5M4VqD
         guqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780413130; x=1781017930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YiJYeG2fCLjzF65IFEg2pHH+5NjWfuJTGzHlNysR1+U=;
        b=BPTUKWy3oKEljJFweT4sXiVa5VpOeXCztzpDykXqQ/CoKKjEiJkLTBn9KLNPPJxUNI
         k621brU3PvHS++P7+qk7yJfhdW69iqOHeF8F49UrMvTIhA+OPjIc98YU5ZxXkQeKiXrD
         FuEykK3sYNMVBTOwatIkyaxznyS/4B7N5foU00kmKhsnOY/cmmTNwpYkuBVsZEbb2KKO
         AZJmPz3rwcrK0liZjLYsWCl83nysi8+mu6dv8ayxQrDmoZRUq0oU4lEg6d4BgJ4KhX4e
         H98KYy4eDQfMkzwpUTuj6clKJ96cQUrAgl4+c7vvSejZCjZvKen1tJP/fw7IS3ZSchSz
         bIzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780413130; x=1781017930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YiJYeG2fCLjzF65IFEg2pHH+5NjWfuJTGzHlNysR1+U=;
        b=WL9gYteUf7BcQ/osnELR/8wYVQIoLjx6U6SKbMML5CglyAxhZYYG7ZdGpYbjmgpYxs
         ogm/xpN4vYH1ghTFJQsoix3HQJWm57JuHuUUVgis/wLRnAEa3IOICr2BUwc9ItqC4amL
         XsHk8EDqUif1mYwkwHIaQnn3onMo/PZ+m2EcQrX9ZpSxZBOu0JZtNUMErhN8fhb+ZQfE
         TB9V4AfLPqDpdWVDyT3klJ/zfFCUnPpzD9GowFpXtEl94RjGLIwdEYZwFlBKEVh5EcI3
         sQZl2DrnNOJLTY9n+aIXnq8uXwuaGGXF2M82KmZqTeG/hxJRQ8JgP7qeuPW/9T9sKCzP
         sivw==
X-Forwarded-Encrypted: i=1; AFNElJ8WiqBJxg5mDncAKQHhJTFygmsag+f1C2uWUpqZJG7w4aS7dBNUY1xz85MHecJcC5KIP81UmrC0DNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YykF4RVgqfzhFouP3uLc2Mypp7nACtbNvYzrnxcBy3Sfv/mgehE
	Mon0rtzUFPN6XQaqsqsi7MTKU+2wh4GX33bCB3+aXmrTOndzAwNVHm581UCP1PC5x9vY9iocpTP
	I4utVnqEz76TYrlYzOmsoMnAssbetxpQ=
X-Gm-Gg: Acq92OEJS1Au1EsjS+wWQGlVzeMKjOvWlATqUfIBWwOhHoG2aqZ3eB44PSl33Fbrdl6
	c8crT7Q+ZVWxtUt/7maS5qRTuRJIuF/fGdAk+9Sd4j3it+HlIJosO4Ny4yx9jDbCJuawcBVTCBm
	G6jWIbd37LOxCsKbCISlHgSi510FhUP0OsTnyA9Aju+tOAlPD4t9k6r22p0L5j9HpYVEJK8JJcl
	+UWDEH0doJfB84lezO3G7WnB4wToNKg6yvN4bYz9EORjVCOjuSDugZ0N9+LruKe1fu0nSlcT++i
	k2u6duKWPf80Fb6fI4brEOiGHuuEu5+d/mOtJUPbpr9Sjtsa1q/SqGGI2RHv0LEmbFNf+mRBsR6
	u+q3QGbA952ck6yCMWLF8j8jaaYngAR/FYg==
X-Received: by 2002:a05:693c:300c:b0:2ea:5057:a320 with SMTP id
 5a478bee46e88-304fa4a49b8mr3613659eec.2.1780413129636; Tue, 02 Jun 2026
 08:12:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602143002.38390-1-laniel_francis@privacyrequired.com>
In-Reply-To: <20260602143002.38390-1-laniel_francis@privacyrequired.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 2 Jun 2026 17:11:57 +0200
X-Gm-Features: AVHnY4LFoVeXSriFdB4h3MAWgoxx4YQ8iyP8wPhbEtGQ9gefjQQAfyS_0pWNPPs
Message-ID: <CANiq72n+tyDcabpwZOR1gHb4mycbpTQbzr0QNgi9c48cSnrZ8w@mail.gmail.com>
Subject: Re: [PATCH v2] rust: pwm: replace `core::mem::zeroed` with `pin_init::zeroed`
To: Francis Laniel <laniel_francis@privacyrequired.com>
Cc: Michal Wilczynski <m.wilczynski@samsung.com>, Miguel Ojeda <ojeda@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>, 
	Alexandre Courbot <acourbot@nvidia.com>, Boqun Feng <boqun@kernel.org>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, linux-pwm@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9224-lists,linux-pwm=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:laniel_francis@privacyrequired.com,m:m.wilczynski@samsung.com,m:ojeda@kernel.org,m:ukleinek@kernel.org,m:lossin@kernel.org,m:gary@garyguo.net,m:acourbot@nvidia.com,m:boqun@kernel.org,m:bjorn3_gh@protonmail.com,m:a.hindborg@kernel.org,m:aliceryhl@google.com,m:tmgross@umich.edu,m:dakr@kernel.org,m:linux-pwm@vger.kernel.org,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[miguelojedasandonis@gmail.com,linux-pwm@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[samsung.com,kernel.org,garyguo.net,nvidia.com,protonmail.com,google.com,umich.edu,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,samsung.com:email,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 135A462FE0C

On Tue, Jun 2, 2026 at 4:30=E2=80=AFPM Francis Laniel
<laniel_francis@privacyrequired.com> wrote:
>
> Link: https://github.com/Rust-for-Linux/linux/issues/1189
> Signed-off-by: Francis Laniel <laniel_francis@privacyrequired.com>
> Suggested-by: Benno Lossin <lossin@kernel.org>
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Acked-by: Michal Wilczynski <m.wilczynski@samsung.com>

I would suggest this ordering:

    Suggested-by: Benno Lossin <lossin@kernel.org>
    Link: https://github.com/Rust-for-Linux/linux/issues/1189
    Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
    Acked-by: Michal Wilczynski <m.wilczynski@samsung.com>
    Signed-off-by: Francis Laniel <laniel_francis@privacyrequired.com>

I guess this will go through PWM; otherwise, please let me know.

Thanks for the patch!

Cheers,
Miguel

