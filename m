Return-Path: <linux-pwm+bounces-300-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C930805460
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Dec 2023 13:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5B6E1F2147D
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Dec 2023 12:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C47F4B5AC;
	Tue,  5 Dec 2023 12:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DO3mPSWv"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5895C8F6;
	Tue,  5 Dec 2023 12:37:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2CE9C433CB;
	Tue,  5 Dec 2023 12:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701779872;
	bh=oaw5ajfNc2xwT+o50ss1Wvzbt1raBQsPnH4if9LcJiQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DO3mPSWvR9AfkhvFPQUJMDZiAbbv7/FklvHViKwmCJrMm8iMGzWpQZYzEcuQX/H0K
	 a7A+nqBgJYuuNYt516nr5J8ZNqRJkB+oBH1fMUVHwVN3misVFombzEmGyvh14Oy5vN
	 /JTjtPGbSg2E4dT3fOUDYta74IowSVSZl1s2jjofEcBy/MuHCx6Mt9h3qF4UzEI3TU
	 DScxuOv7FgUIX+2jzME7ftmXdFhZ0X5Kon2JK/Jv7l1ReKpsQXKwy0KFK/Sw4qlEoP
	 9E95Xs8kGpo7fDg5Yvbr3mxoxYx0+0w5o40ahdutyXh3sLxk15+yjnZzx5eg4uG486
	 1P6U52mxhfUZg==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-54917ef6c05so6986761a12.1;
        Tue, 05 Dec 2023 04:37:52 -0800 (PST)
X-Gm-Message-State: AOJu0Ywqf6tJPwF+BuR1rt2aH7xnsNjfRk75/VaMWKd+cMoL0TGSCIhw
	tLPt6vWTa8HLTQTji/8X3jp0YAw/Jq9h5/GNYpE=
X-Google-Smtp-Source: AGHT+IGpvIfwRkg2wXFpJm8JBXaBCscMa9BEY0aBxmuZm1DHz1oIBKXFkU+8RDA5ynmWw7UWKf0unB01ocBdpwDjSAY=
X-Received: by 2002:a50:999a:0:b0:54c:47cc:caef with SMTP id
 m26-20020a50999a000000b0054c47cccaefmr3042102edb.53.1701779871163; Tue, 05
 Dec 2023 04:37:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231106095205.231210-1-alexander.stein@ew.tq-group.com>
 <20231106095205.231210-2-alexander.stein@ew.tq-group.com> <20231205123617.GI236001@dragon>
In-Reply-To: <20231205123617.GI236001@dragon>
From: Shawn Guo <shawnguo@kernel.org>
Date: Tue, 5 Dec 2023 20:37:39 +0800
X-Gmail-Original-Message-ID: <CAJBJ56Jkc+iy4wCvY=jr3OwQ_nXdDSezkjfJaejmhWDoTDEyLQ@mail.gmail.com>
Message-ID: <CAJBJ56Jkc+iy4wCvY=jr3OwQ_nXdDSezkjfJaejmhWDoTDEyLQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: pwm: imx-pwm: Add constraints for #pwm-cells
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, NXP Linux Team <linux-imx@nxp.com>, 
	Philippe Schenker <philippe.schenker@toradex.com>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 8:36=E2=80=AFPM Shawn Guo <shawnguo@kernel.org> wrot=
e:
>
> On Mon, Nov 06, 2023 at 10:52:03AM +0100, Alexander Stein wrote:
> > Only fsl,imx1-pwm comptabile devices use #pwm-cells =3D <2>. Newer SoCs
> > supportinverted PWM output, thus #pwm-cells needs to be set to 3.
> >
> > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
>
> As suggested by Uwe, I picked this up too.

Sorry, I picked v2 up actually.

Shawn

