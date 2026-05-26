Return-Path: <linux-pwm+bounces-9162-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOjIFM/kFWrdeAcAu9opvQ
	(envelope-from <linux-pwm+bounces-9162-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 26 May 2026 20:22:07 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8045DB48B
	for <lists+linux-pwm@lfdr.de>; Tue, 26 May 2026 20:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4E451300F633
	for <lists+linux-pwm@lfdr.de>; Tue, 26 May 2026 18:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF85421A0E;
	Tue, 26 May 2026 18:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qlXrT3lW"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8142F4218A6
	for <linux-pwm@vger.kernel.org>; Tue, 26 May 2026 18:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779819721; cv=pass; b=N3UYjjg+6xA7wghQrVxTI58SSxG7by2PgokgozyQwJOB/5YTB4XqXzCxNEKKzdjKVpsZDuRdUMMV8Z/N9+u2Et5n7vo+9R2Abp3uw8SiPgsjErEztdkJZuDYvaZ1VRxwsXppYQ0HlUSWhFoLHwnaNzHFObd/9DWhT89fUKWkvBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779819721; c=relaxed/simple;
	bh=zZlGXRWOTNjKRRnkKz6c2KolMrR/moiIJiI92PNpY/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qporlGSYJzSLteor+sYRYpO689miOV3ekCckOHHhOy5JSLlGJj0zkSQvBm+SavlGCtL6h2lpW/RqbXEGd0FwsJbbd5i987zn8d9rL0XWtsoEZrZEmboYqE8dRKQ3fKjopg41hMPIZrGyCJEWfS+7HZLtoVTo++n3IHPKzG+TyEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qlXrT3lW; arc=pass smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2ee4e75bc93so937951eec.1
        for <linux-pwm@vger.kernel.org>; Tue, 26 May 2026 11:22:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779819719; cv=none;
        d=google.com; s=arc-20240605;
        b=HM/SQDbZ5U5vHnk0Y47s5TmXKO86MLWr7vCiKOIfm0wYIkDidSgE/hCewC/XTZVJ73
         owPemOBqJsRTwIfvpfBm9Dlrnvj/yek9Om+BqmJt3mJ5jad3349gX5r0eITsPiyb5q86
         E7B2k6rfknhwrcll0wsFoBPD3OMSb4aJw/2G1rlWyB0Bs7mYY1254TBOG2J7aL7CJ3Ym
         znXGtA0xPKzDk+gMv1dyJxFKkHUMfz/K5QqpqFD6HW9cjOW0lz/M5DNoG0cm0Pk8UsHF
         Tz8PtLmtuF3FjROKM8ed+IDccuMnCYLdVV1z9heuNrtDFGcMkSHVeeBY3Pe8nXUYrkVQ
         5gtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zZlGXRWOTNjKRRnkKz6c2KolMrR/moiIJiI92PNpY/U=;
        fh=sDoib4VQ6GM/o6DH0SLhKsFOl9h7ZysomuSD476LgBs=;
        b=K52XVps9bcNAkpE0/bF77eo86SjQOrbx6NtuQdCNEyVT7Km2wHiXT8VO6pFWFlOekC
         iyMKZgOT/mftGHtA7ar80ouBJu3H8uIxK+uaQdXz8Gz3p36vr2Xty+50Gp1KLvOHVwin
         AfHTTPHKr69MFMCGbGvbMxuMzd3nYjZvgqLRZvR+2giAaXMT62wEtKldvTqSpQoNeTmB
         Z8OLh1nPLNyAQmtHbANPdmhFqNGIOdX7BqUx77znlHCKRZ3xCAmz0X1iJh+jID3AsYdO
         FzzDsqGVEjgTYI+FpOztbZkf8PkGScYma7FOefx0vx/g6rB7yiMC3tu/5W7dfEXIm+tP
         VyEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779819719; x=1780424519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zZlGXRWOTNjKRRnkKz6c2KolMrR/moiIJiI92PNpY/U=;
        b=qlXrT3lWn7CREfHFK9zMeIZFg0kNvix1PpPz9wUMf+cvc2WDwVU0o4MscpxyJZhsGI
         CwXWZ/zyfXOhEd55gNKMGYb1D6RsPL5KQCZ8ZPTolJcNjHcvsCeR/O0ha9c4quLkTHBp
         9a1881kAzfVfGOoLWAv/H1W7QLffXVCpSuc+KeweCYGVMxhYtGMys6zfzis06qTG7lgh
         q7IJs5llE5+fvdiKNtaVooKmVgF2yaUjVRdYtljW1wmVs4FAjMBJed3TUB3bpB3Tpl+7
         J4O28IKYG47fna6IZj6UJ8i/pJH4mQHEAvWcbe6pTRn3yFCJi07wFqJsve15L+6ZnUv1
         9C8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779819719; x=1780424519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zZlGXRWOTNjKRRnkKz6c2KolMrR/moiIJiI92PNpY/U=;
        b=SiUIL+xo42eEATFQokV42nrQqUbx3saINzGVXftaWVuVndqC24Da133USJv49e0OWL
         DyNPJ534i+bfmqjyiVMjMRXwO3CQ9XUp2afEdo2PnTAcQMRsCz8E4F0jUycfaac3kQBP
         sFK5j8SxY97NQ03Q9LNqK/NxPw0ARh0JCkJ7SKUKUwfKxsHvIQASH5CkIhiq9RLs+AS8
         YbtuLBYsWn/HECjKLg0QICtQ4j6trVcOoshrPtAsJWtuFc+lFjI5ceEsS0xzxCxSGhCq
         /K8XTuVgkqdi22JR+XB612WCrjIavtkjUXc0rGFmCpvIDrISTenuK65MfI+H0411nLgE
         DzQw==
X-Forwarded-Encrypted: i=1; AFNElJ96iWF2+3KGdGuUmucQE2LV3wNbL8IGjts1w75iN4uj+l4euHvtqMGooDL8JPkG8HC8F0pN73f/K24=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGJ6gcM+clCEx/tcz+VCJxzcE3XyuAGguyMnlp1JFdjmrMcAoV
	RItTI3RLnx6Fo1UFDZ2LMxfk3v2MlQ73HHmGnH64lQRkJ+Jkw5+8cCmNNa7lsCeDlokzdIh043Y
	4tpR6jY9Wi8u4fncOZCu/36okimJk+kg=
X-Gm-Gg: Acq92OFUd9q5P7b8qJAnyD7bGSYsLNzeu+Lqsxmbuk480tYQHfXlw8PfJf7f/8rP3Qm
	pySnGLroi6CUtn8k5heQOqQeJxnEufCNorM0yOj/qtHSP0yEam4OwfJ7QTIp8Qn2SeZVgeaFNRC
	+oIFD5tTd6oVt2rBNlAqGktQI8idtF84UiYa2Ikr7VJS2MW1RjRSjhC8LRfhMkvP7AWUOeX2fzg
	KVJSbYO90PTNrgd9cEwUisBFnjHTW7EUjX3WUqMvUCztUJDz8KqvQKYDp06CgEFn+DSsp/Q5kwK
	sagDwk5hlRkx914woV1QrYNhQdNwLJ73WpnmIUffswpNJHs9/GURkCMhDAQn02gEIRdiHKyxcmy
	tZMvibVl3lb6ip1p8nTAfgd4=
X-Received: by 2002:a05:7301:2b06:b0:304:2af3:5fef with SMTP id
 5a478bee46e88-3044921564fmr4123223eec.8.1779819719412; Tue, 26 May 2026
 11:21:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260525202921.124698-1-dakr@kernel.org> <20260525202921.124698-3-dakr@kernel.org>
In-Reply-To: <20260525202921.124698-3-dakr@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 26 May 2026 20:21:47 +0200
X-Gm-Features: AVHnY4LERaGUubmcoHWuZ6pDVh-Er4DRAsv1wa0D_Oc3ExDNDH2ULqOUOsIQmwA
Message-ID: <CANiq72mNqdOmQ3Va=EF-Fg+-BXW=O=px4z4+YQTS6wzL87=ZHQ@mail.gmail.com>
Subject: Re: [PATCH v5 02/24] rust: alloc: remove `'static` bound on `ForeignOwnable`
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, acourbot@nvidia.com, 
	aliceryhl@google.com, david.m.ertman@intel.com, ira.weiny@intel.com, 
	leon@kernel.org, viresh.kumar@linaro.org, m.wilczynski@samsung.com, 
	ukleinek@kernel.org, bhelgaas@google.com, kwilczynski@kernel.org, 
	abdiel.janulgue@gmail.com, robin.murphy@arm.com, markus.probst@posteo.de, 
	ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, igor.korotin@linux.dev, daniel.almeida@collabora.com, 
	pcolberg@redhat.com, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-pci@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9162-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[34];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,nvidia.com:email,linuxfoundation.org:email,garyguo.net:email]
X-Rspamd-Queue-Id: 3E8045DB48B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 25, 2026 at 10:29=E2=80=AFPM Danilo Krummrich <dakr@kernel.org>=
 wrote:
>
> From: Gary Guo <gary@garyguo.net>
>
> The `'static` bound is currently necessary because there's no
> restriction on the lifetime of the GAT. Add a `Self: 'a` bound to
> restrict possible lifetimes on `Borrowed` and `BorrowedMut`, and lift
> the `'static` requirement.
>
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel

