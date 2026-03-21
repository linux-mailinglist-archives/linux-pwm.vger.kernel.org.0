Return-Path: <linux-pwm+bounces-8323-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIuzC1GzvmkrXgMAu9opvQ
	(envelope-from <linux-pwm+bounces-8323-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sat, 21 Mar 2026 16:03:45 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A78742E5EF0
	for <lists+linux-pwm@lfdr.de>; Sat, 21 Mar 2026 16:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5AB903007AD6
	for <lists+linux-pwm@lfdr.de>; Sat, 21 Mar 2026 15:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0095338B15C;
	Sat, 21 Mar 2026 15:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kDL9dgrY"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BFA28B7DA
	for <linux-pwm@vger.kernel.org>; Sat, 21 Mar 2026 15:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774105422; cv=pass; b=FxGDnciX8xn7LbUZu2cAo/eiR0xwtYgy2b/4+vhYTzwiLUWrXUaRrzuTM6wXqaikn4+1L32RPnxgmsLr9SHXez7geTpF/pnwc4A1XJnxH8JExHEeq4mMm/+R+OcMBvDJGP4s9QAezF6wVZyU2daDvPUsg9XdbgOF18bfcGzvFTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774105422; c=relaxed/simple;
	bh=ucO0y1q7MG/iWCmErUhGurBrhiHi/90k+hcQ7EeukC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u9Ofnaqm8tm/cYZj8PTpz0gNJ/gvBeHhNf3TW+796e1/wq6T3j/eKs6AcRaAsM82dYaJLvPtUXE8ZiI5mV287+1QTcb96AjiE4Xt3W8sHMaVvKSDc9TqkLG509II8GJ9MKf8CxAm+BGPulbOWj7tLoAOPnL/DT3JNBaPdxX08dk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kDL9dgrY; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-124a7216c9cso191996c88.0
        for <linux-pwm@vger.kernel.org>; Sat, 21 Mar 2026 08:03:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774105421; cv=none;
        d=google.com; s=arc-20240605;
        b=hPKav+6FaeZ4+scSFuMoSFV5MX/Pt+46rZzdsvupgn+JWuXkWwhjITa58Kinp+wk0e
         Rm/4GW3tf8juw3Brm08GjgBjiNSPdEmwxE1nciKrRhBPVVbAWiWmmqhXwaCv2tv0i5I5
         lh9UZVG10LTLN/rfcKGZbArWQfi0tBcPe+7M+SG58QhTfo2/unwzh7H3PT6LRrUMkabY
         rTN5/nnmkJJMRitPBudruzQ5LBsNnDINMAEn07Asvk74dCTmj7hdVjJwJrAAU/7EeuNd
         QIJTkT8aJr3QfMlDh2fgq3mUFzVSH46hEsW6zG+Bv65sfYHoeDBWkyA1ZcQufxUmss+F
         Y6xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ucO0y1q7MG/iWCmErUhGurBrhiHi/90k+hcQ7EeukC0=;
        fh=bVU8cHYgLM6Z281aVcHVw36cgsX/GbsCGY6rWdMTvgg=;
        b=QBeGc2tvLfwP/lGSj4H0y0rEGjaHbwsY+dGojwcfie9FVAmXHgPznZhtv7jkX9Wmmh
         XJIZEDnQQcfbhTQYkAKmhQbNFNuEusIXFNutbHQ3oO2YA3fJ/FCA7Mi2EGdnehW9XMgz
         96yklDEvAupgzRy5Qvwv4G6vXd3C3JOcFYzQShtp6HohcpOkRzyODx2yd1dlvZOrERu5
         NYmrzN/x63Bicao6TUCXA7Uf7AbcjsxyLkzKhh2qkSAtllrBKp0jdu8CDp/FvW4s7c9X
         ehDpRpuEMWPQXmQu/Z/quw3H6Ec97oY4D+3+9X83havwfHEfwI+WCpD0McywZLQdVb3/
         uPkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774105421; x=1774710221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ucO0y1q7MG/iWCmErUhGurBrhiHi/90k+hcQ7EeukC0=;
        b=kDL9dgrYHwKEyaRrd+d5+lqUntzRbNwcvGj7HDmbAxjXZBs1N5z2HMa3EdYfMZXCA/
         F/5yW86ZIjjXeD589p25QEJXAU4rOdKvQsYsHF+ug+cHhztBVf/UspiSoGzGWmuRdndm
         RedtOW9GQ0zqcvuTitJBDGikqUpA0faWvCZSn18c5coiW/o0atsjFFFoVdPrE0z6Ik1W
         tpFTehc/FjSZw0CgLv8EFBgy3zIwceJiwt/UYXFUAAJvuNmZFcXXTG9y1YfALNy3eJjt
         fogHmBc6hedyvGVBU6eYhJfI9Utw7CGj1Xsyed42yzN8woCLxLiVGWebyeJtPqzV7Et3
         Xmhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774105421; x=1774710221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ucO0y1q7MG/iWCmErUhGurBrhiHi/90k+hcQ7EeukC0=;
        b=ogvCgwlNO7ZPAMyl52empMAJPKJbOuB0/W4TTBPrHzfffsqLMYl2ulRWyGd4bWGyDF
         pzMWpSECPaBMgNoMHWZnXYEvUwtuI8WpIwZNILRodMHuB2tz+jeL0xxOPU216dwuCVjt
         upyvf0yv6kLuynLo8KvxobN7dK/UINfgcCJRMQHlrVxaSBElyRBRTKTnn5vHpdFMCYb7
         ZnkoC5AB4lzGggGtyVFaQzESmliY7fUwQbgYzSrx3kQarrMJktUXII6Pfu2aOMeVrseM
         5TX+gT4Vdfci6crPllLeX4h74kR6P5YRVD4E1QexKE/Kkn/tHzWgthBSEGLgb2fn8eI2
         McKg==
X-Forwarded-Encrypted: i=1; AJvYcCUJe9zmZ4q4CozqqvzBlpDbrs2+LXtnP6CFmFpkJwQdBLvzDtdugEwkD3vGRZyMsxigzU5h7mQ6sVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvfeZ7aQNp5va1lHjhn44P72wOAyB8ZcKIkCOBSm9TKCxwjOLm
	QKw3O8vMoF8SfI0O9Cmq6MviyM0QqICskJqOMCpk1//ov5Oja7nri1xvzcY08jjcWflpcdTc6Vb
	dAEaGZhUmPwSAuwNq6J9oNHL3Kscr4nE=
X-Gm-Gg: ATEYQzz+lLpktOhJ4hN/vEqbxKcitjIhNNGfFJNOe5TeT18H8zB3bSQ9KNwVQd7ysYK
	KNtg1QSZ86I5OXBq1apY41xeWc8+yqqGgA46yKnZLq658M4AAL4AcV9eFz6wtWYmW2I1RPhkLIv
	P/ECCBExKg4oj6hNp6GxlXqYudXBdTMGBM4JukWrCAEXLEdBPbm7rVlbEh82W/DFJgTn2woQcD8
	g1VzXbUuBjddKr7/LuvjiTtemTrLzN/gVFMDlAYwir5MqeZu3+0h2AlYG/qDkSFqojp+A/vpcBC
	55gA3UAZnUpIuG7Vyi8O7KBzvbZuWLOdvc0k2dY0rRip3YphPaIvp7gB5rlYpqsH67sdurBirjU
	n+ijB/jm3u3Xi5OMGKNk/nvk=
X-Received: by 2002:a05:7022:792:b0:127:3480:7ca5 with SMTP id
 a92af1059eb24-12a726513cfmr1588676c88.2.1774105420874; Sat, 21 Mar 2026
 08:03:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223-clk-send-sync-v5-0-181bf2f35652@google.com> <DH7L09UFWGTK.2MT0OTWH1DUV4@kernel.org>
In-Reply-To: <DH7L09UFWGTK.2MT0OTWH1DUV4@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 21 Mar 2026 16:03:28 +0100
X-Gm-Features: AaiRm52lxzUk0_iCcIFX3-uHQqZ_28CgqK_qR7We3jIMceDCHvhnu1d2ud_6c3s
Message-ID: <CANiq72mqpGk9DAjkt+Ohhw9K2xQChKtUQXPM8iucfokbYT_uTg@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Implement Send and Sync for clk
To: Danilo Krummrich <dakr@kernel.org>
Cc: Stephen Boyd <sboyd@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Michael Turquette <mturquette@baylibre.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8323-lists,linux-pwm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[172.234.253.10:from];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,google.com,baylibre.com,linux.intel.com,redhat.com,samsung.com,linaro.org,garyguo.net,protonmail.com,umich.edu,collabora.com,vger.kernel.org,lists.freedesktop.org];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[100.90.174.1:received];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: A78742E5EF0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 12:43=E2=80=AFPM Danilo Krummrich <dakr@kernel.org>=
 wrote:
>
> Alice has resent this over the past three cycles, but it hasn't been pick=
ed up
> yet. Please let me know if there are any concerns -- otherwise, I plan to=
 take
> it through the drm-rust tree in a few days.

+1, it will keep accumulating changes otherwise. Alice asked me about
this one too; I can pick it up if needed too.

Cheers,
Miguel

