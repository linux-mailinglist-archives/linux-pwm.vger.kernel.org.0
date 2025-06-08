Return-Path: <linux-pwm+bounces-6263-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52060AD144F
	for <lists+linux-pwm@lfdr.de>; Sun,  8 Jun 2025 22:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E79E81889C3B
	for <lists+linux-pwm@lfdr.de>; Sun,  8 Jun 2025 20:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8551D6187;
	Sun,  8 Jun 2025 20:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PbATWU2c"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E429BA45;
	Sun,  8 Jun 2025 20:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749415674; cv=none; b=f3SPR3jhFKq08vJ1e+S+g9qnwYRUI9xmrULTYqJGWj8Df1ukyvd6j6NTACGWR9AyK6Yc0CtM526WIibs1jiSs/WbELNuCI3d7Z59NLGZ/Dfs0EWUxY2FNjneTlJgZfLD61sDkbBVN96K086Vj7M8uhpV1XGyH61E38I5gN2RA54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749415674; c=relaxed/simple;
	bh=ebF6L3yW+3ohMAChacTbx/9GAwBaMrhyLwIY4VviJvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ILSqCOJfMrw8AtpB77K1lQsKNcx4QWP1SGCWroHUyOpLZX2rhTatZMQ2woHPU1pZNpqCqqXfGw1O9NXgX9eZCbqBdwzL/2SQpdhScdMfs0tsrbztWwYqzQLpkVnu80Tt4gvbVCbscyFe3qKJWQ+gD/4A2NyxCV+Ime0Br/z+jWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PbATWU2c; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b1276984386so453254a12.0;
        Sun, 08 Jun 2025 13:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749415672; x=1750020472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e/NepSzNK7cHJVdKlMHYuPZmDL7EOzwuHy5xSr7Gp+s=;
        b=PbATWU2cnA/SJSTcjsUFNYFRMnJxXPBSZ9jq4nykcGbBITiMTZICtDAAWGE9hbLc74
         +r2aQEVQ1OPQTcC3XK3JtT9QGcemkMUOB/21Z3jn5CNgt2dlHajC0mqv/5z++UlKFTy1
         DdJX0UjyPk32tsmb5Gyv/l1No5mHlhyWe7R6aBV1Hg7+mLOoSxiWlxS4PAwUmLa1aleo
         4/SpROQjze/BRCflv4H2DBJzwAdVkZDoMMBqgtIdN8d8jTyheDtlp13NTPnxWgDbIRpb
         NXMxgTF0o+ZbovwKO9cWOndgFOGJed/oaDAXgPdNqVE6ZnaxqssW9rd0zP0kY2jjt3CW
         fpzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749415672; x=1750020472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e/NepSzNK7cHJVdKlMHYuPZmDL7EOzwuHy5xSr7Gp+s=;
        b=IckfEKyFQxNLYBh9Wv417YZZ6bst92mdKyBtY0VyGWGGO+9fAl8BQE19xH1c3FTFM9
         PvOhR4Zo40fNHSPsLe6Abf/Mx4vpcfzi4ylEcSRN1vjAo/65fv024djde+IL3KIZ4LHR
         k2C6BilEDOrPruYHCvMcHzSJ1VcK7iwqg+Ci+t66GTWUz3ALfcwkYabU89kzIuijb2Y1
         hJK4H88EGa2JJpDF/K8bs+xLTSVGn4Tj9R4ZiiCME4fVPr8AUgjwhZGoDaaboSVEr6vJ
         CeBfO7IyugGlt3/lP+DPz6d4M/y72EpuxUPT1XeI36cFunupsXss35z9Ch/gmwBeZUR+
         r45A==
X-Forwarded-Encrypted: i=1; AJvYcCV9ye9+OTO9RFOUjNXWkjxyzMzOZgyFAiCbE1rFkXeq3XRcZ1IeV74xjQ2OgjJR4HLfUx74cZkzHNeY3tBc@vger.kernel.org, AJvYcCWGbObFsCsw7vXZ04+vHgoKa7BkTwsK5wiAvpjE2xL/SRHb3BsNpExZI04ogaj7hKyaS1iVvVdrkb9Z@vger.kernel.org, AJvYcCX/uRfVnHGduK49IT2AmXlRs2HmLZxFWHsSHgz7ePUuvMS5JMJ5YlkRsQPOg/4JCq2dIeg70onVUuZd1PwR618=@vger.kernel.org, AJvYcCX0dNziQ/0bDSQRDd3Lnw3OiW88ooslvWM7r5PgEwuF/TK85DNTsGbBR+7CE69ZcUmvg990LiQdYFGU@vger.kernel.org
X-Gm-Message-State: AOJu0YycDja4eIm0aEUIBvwLTVKu5nVRBUWzE2mVhhuxTllmFvMnlO5R
	PLwT9sSsOFh06FI5gLtc87/2GZp8cL0LW+CDKKxWCwt40lYvNRDz3QfSaGygtDGPfahYHrWgPIz
	wuM/sW13ymyI7GyGDFE8LVI9CQFzWzB0=
X-Gm-Gg: ASbGncv/aVpDtkeUT0Jn3ZIrJc4PQNnxrp0NFNTkS38e40AIjEGFAHc3Hx9WPaLSTBN
	PIRIu9MsqRvv3y09Oih00gFWphXd3z8OD6fyfo8n/MX4/r21gM0ybnSsIeUX+LeZuZuiTUYuI8u
	5kvW0lUazJzTZKM0M+eeaCk0uP6CQI1VSi
X-Google-Smtp-Source: AGHT+IGMuXINEZm4WUqJIT66MF2vg+ybkmXgawlTKOKqE5f3w0CWVXxYZlA0lxfrGl70z+aRQlCRwjGEVMSn8hyBYU4=
X-Received: by 2002:a17:90b:4b85:b0:313:2bfc:94c with SMTP id
 98e67ed59e1d1-3134e43144amr5309627a91.8.1749415672501; Sun, 08 Jun 2025
 13:47:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250524211519eucas1p218997c69b98b14d3af2eb6bf4e9d3187@eucas1p2.samsung.com>
 <20250524-rust-next-pwm-working-fan-for-sending-v1-0-bdd2d5094ff7@samsung.com>
 <aDJGgLZ9tITwGBxq@x1> <b5f4af17-05ef-453d-8f04-283590ae5b87@samsung.com>
 <DA5YY0YF28GO.3DONTQDLY6VBD@kernel.org> <aEXBH5r05FkTxpV+@x1>
 <CANiq72k-FmZe3P_y6FjmiqXViqLKXkDqHY1-KLfmgwAe98oBAQ@mail.gmail.com> <aEXrZvpTD30a5OhT@x1>
In-Reply-To: <aEXrZvpTD30a5OhT@x1>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 8 Jun 2025 22:47:40 +0200
X-Gm-Features: AX0GCFtkgb9NQ12mbcXrlhdSwOY0B7uS6yd2CXG1hnJnfVtwyAWwRJ7-DZ7mFxY
Message-ID: <CANiq72mn4sRzmkFAJ0fKhwZMLUi33DBLNzyEF2BTPML_4Ya+Bg@mail.gmail.com>
Subject: Re: [PATCH RFC 0/6] Rust Abstractions for PWM subsystem with TH1520
 PWM driver
To: Drew Fustini <drew@pdp7.com>
Cc: Benno Lossin <lossin@kernel.org>, Michal Wilczynski <m.wilczynski@samsung.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 8, 2025 at 9:58=E2=80=AFPM Drew Fustini <drew@pdp7.com> wrote:
>
> Thanks for the quick response. I seemed to have updated it with:
>
>  cargo install bindgen-cli
>
> And it seems Linux is now happy :)

You're welcome!

(By the way, I always recommend passing `--locked` to `cargo install`
unless there is a good reason not to -- sadly it is not the default
for that subcommand)

Cheers,
Miguel

