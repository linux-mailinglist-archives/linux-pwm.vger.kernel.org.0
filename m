Return-Path: <linux-pwm+bounces-8334-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGdJEISJwGmBIgQAu9opvQ
	(envelope-from <linux-pwm+bounces-8334-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Mar 2026 01:29:56 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AECC42EB43D
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Mar 2026 01:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9FFB13006B00
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Mar 2026 00:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFF018A92F;
	Mon, 23 Mar 2026 00:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4+bMxds"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907C412B143
	for <linux-pwm@vger.kernel.org>; Mon, 23 Mar 2026 00:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774225792; cv=pass; b=NxnYPvN4eO5CFeJNil2//FsoWUzYPDchiP6nALkePJ1hqCBIjJnWYVfCcMU3t6qVzzW0MFM5ziCo55qroGyMLquT4GAP8rNFGoPGcP/6U1HnwTrCT3SK0GpLzEpuwvPpH+gZ1XUfIKP9jNFphrqnW0E5BXUX9Y5adW3MIrkw4wc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774225792; c=relaxed/simple;
	bh=9cbHdiwHVMGwunEQtejbJGfCgtUR/AP8Rb2GG4SIKJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PYbxshbBqVCVXJON7a8iUmOM9Hcyxq9DgjZWDhlzjkc4/lOzK8YGRgF8PXG9hcmtgNEjoKyKimXmui2O/b/YVReDxKsnXaI4g3rEsYJFQtAOULZPdBaeCSVSPS/zGh6al/KhTWVv2YrRbWiYKIpbn7vPCMW7J1RkrSAbCpsAT5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L4+bMxds; arc=pass smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2bd801b4078so232285eec.2
        for <linux-pwm@vger.kernel.org>; Sun, 22 Mar 2026 17:29:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774225791; cv=none;
        d=google.com; s=arc-20240605;
        b=gJpH/uZxqYDQsrDgLBbVPcPgxVIcdgdnFfvPTPpJPke9oj91GPBNpl9QYAJrVyseUY
         590gkF0Nwy2WnnjlzFqLKN17MiSrzgJIvrvuu7RI7lcfAm1wLAz9s2lLOzXleNpuJAKB
         WEpc/E5DKC59AtjWM0X/1EXgcakjefzoIwJjDSghkP1GkVCpw5Ah8Cz4rqSKJnqeIfPD
         7AqR82+zcbFomonDcTXb7hyrsuiBEBwlmnOX5EKqHhyef20+rahfhBOmLZlSwCDW+DNW
         8K98OwoNUvfvNvofUPfS9vMOmHyvwGv23+jFEmwHrlw72Kp2N//qRtr/6lph0DEpHduM
         yeRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9cbHdiwHVMGwunEQtejbJGfCgtUR/AP8Rb2GG4SIKJY=;
        fh=J29ISInbb8zhVz6Ib8DFmaxnxwpZczmqxcwTGst/PbA=;
        b=dqt2LJX+nsS7uPa8wsg8BOR5HYkhddZ8+Q9C4wLO0aZau3YtiM7FIlHLyFAysBTwCd
         qOakuFOBFgvJhphNacSYU44YtUrlVrmS3EzONB+vo4pdKorxv0RYZOgIRsecKSFQwnF+
         1YFMkkj7nGnj4jfvBdTepqWSWV2v+M8fvZuOffn83Q9cenD+ToaneEj8cO9k/oEDu9N7
         u8oQEagihwmN4IY3eyxX4b/iihqGyX+UcJn05uxv1BO+zLC9hDcEvJ54/kp90yrWYsJv
         As3kae5YgYaCPphJHQAtSpFNwkxhQ1ojiNOysgljm5JYdhVT+OEVWTy1XAP7bcSEVYny
         PsDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774225791; x=1774830591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9cbHdiwHVMGwunEQtejbJGfCgtUR/AP8Rb2GG4SIKJY=;
        b=L4+bMxdsyOvjNUJmmgOMJ61YIFEOI6sVTpta5OQKCSIJMsjzGDsDWDyXyi5mRunoBE
         cMzMCm8F5nwYStA7JCfuIQksncHUxW7CZ1IxyU/EdFZ1iqAjs7Ci7omYDGEyiDFc7/N+
         hrQgbMCnzkJL2oieDU/CP09xahqThS+kqwLM8zAViF70vNIR0Oy9M9L8afEjoVCCfH2b
         uNmQcaWICI7JsFrdy4BTI1fQWKrbRYjYd7WxxQ/n+6sahsgmvTLWceFB1nW/iGzFBh1d
         m13bGOPqfqmCklXlbQaBQujwmKc6JRh1w9ROhVV+9zygFXsvO0nxOSbXvGEx+/eIF0DU
         +5bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774225791; x=1774830591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9cbHdiwHVMGwunEQtejbJGfCgtUR/AP8Rb2GG4SIKJY=;
        b=mHho8qZaxfVVe1MZXJBqzWTa5dhKkUEkS5xGEUGQh1FDgoWkimKCzUCcZvduldnU0c
         r/BUPc7SuPf0mX/s/eje91mKPEPabDtJk9/uyJo4yyfG4eiQ7YkRSl9MeQ2JgjP+6TOC
         Cpu5nmmn28qT1zsusM974sHazQHW1tNqw6b3QmYSbsthMh7uumk3LfQx7JlQGLPFq9Fw
         vSJE1MdoJMQSLYJ/y7xEl0bGzCtRZ2TpB7Gc6zdkq8reNWy7o+aygrbV0E12793loSnL
         lV/x3gZA6JOYr4TukOrAud+L93w+q17B2Mi6ORNIF9dqDCPSDnsid1OaGFUW5JJSEMmm
         K6Sg==
X-Forwarded-Encrypted: i=1; AJvYcCV/gRd8/4yhaWgtCxSalAkY0oNW10EqyvF3flrfXKMehVAQRjy8hSTK3RWpJwHMJlonG7kPTs+vyp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUxrjZgKd/jn+We5eEWIUsllHUq+ChCuV/7EsRdjdSRvTqQGkA
	hzR3CN8eMR9x3VSKj7VK3sM+G4fkL2ISuTtEuGEbHmm7QlEWszHkBMoJqujzWEe+vcFWckMgK8G
	H4tIrOEspjGU7YawqIIDkEJRmjEueWtE=
X-Gm-Gg: ATEYQzwA9GTuvx7IO1rHJhwIF+gSkXXv9Ywtjx/iZ1Xf3ESn3pD91M+Wd5sFLuWX8Ki
	A7hwwHIlOY03x8ds5tDnYYTmpolB08TzrLt9MENmuhNWzoDpcRn5tnYUQLj30176pkSDCbLdy6q
	rRFGE3hOBDxdJiWMh+UP6XRH7uI+ALuLKPhLp4K6CPX2Nzs3wgD6pIQvXYby54q5qF23p16Vvbg
	tNR3PwSGRVUdYzqoAAWB6jNP1EwyxvMV9tq7XdE+rO+VU6ZF5ep2mWDWceyJVtUqu0KL62oP7nO
	/Wffyn7aeKCIMwcBmA2TYxsDNJNbAzJwjOzqYUTPygFnBsyqW+W4X7tpuQgK/HsREnZApG97sSm
	ZIIppTJgYP7J3YzQSQ21ip4k=
X-Received: by 2002:a05:7300:aca5:b0:2bd:a3fa:9bdc with SMTP id
 5a478bee46e88-2c109862618mr1863580eec.5.1774225790638; Sun, 22 Mar 2026
 17:29:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223-clk-send-sync-v5-0-181bf2f35652@google.com>
 <DH7L09UFWGTK.2MT0OTWH1DUV4@kernel.org> <20260321-awesome-hot-kingfisher-5d9f55@houat>
 <CABx5tqJvOFEzmadeXpDxSUjkghviqtP0jo+kzSB5X6u_P_j2ig@mail.gmail.com>
In-Reply-To: <CABx5tqJvOFEzmadeXpDxSUjkghviqtP0jo+kzSB5X6u_P_j2ig@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 23 Mar 2026 01:29:38 +0100
X-Gm-Features: AQROBzA_7BqFHE98PrvfdrcuinIkR-uI5M2p9UFW_-ESSorfSt0DS6xmhkt5poA
Message-ID: <CANiq72kAhVALH=CoQ37GPOKp_w=3_kZYu3Rkwnwc4CX3V5e9Sw@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Implement Send and Sync for clk
To: Brian Masney <bmasney@redhat.com>
Cc: Maxime Ripard <mripard@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Michael Turquette <mturquette@baylibre.com>, 
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8334-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,baylibre.com,linux.intel.com,redhat.com,samsung.com,linaro.org,garyguo.net,protonmail.com,umich.edu,collabora.com,vger.kernel.org,lists.freedesktop.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AECC42EB43D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 1:16=E2=80=AFAM Brian Masney <bmasney@redhat.com> w=
rote:
>
> I'm planning to send another clk pull at the end of this week and I'll
> include this series.

Thanks Brian!

Cheers,
Miguel

