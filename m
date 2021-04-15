Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2C9736076F
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Apr 2021 12:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbhDOKr0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 15 Apr 2021 06:47:26 -0400
Received: from mail-40140.protonmail.ch ([185.70.40.140]:25667 "EHLO
        mail-40140.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbhDOKrY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 15 Apr 2021 06:47:24 -0400
Date:   Thu, 15 Apr 2021 10:46:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1618483619;
        bh=FqqoljThLpOkKq3HVnBx6falyOkeZosZYHA11X1CY4Q=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=VFX0DLTPJGS+E8PEcqknTVMEkNY7s7p4wpU5cvvYem3E8esQCFuXBkL+29Y0d6+JE
         kihOVEXGKkBxFg+Jd+M949kBliz9opJXziMSQm/bmxJ3mQ8xUw5yQdC3RRIt9pkmV+
         PFwQA241d7BNnb9o1b1tfpjYnhhooef105I4Lnvo=
To:     bjorn.andersson@linaro.org
From:   Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     agross@kernel.org, devicetree@vger.kernel.org, dmurphy@ti.com,
        lee.jones@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-pwm@vger.kernel.org, martin.botka1@gmail.com, pavel@ucw.cz,
        robh+dt@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de,
        Yassine Oudjana <y.oudjana@protonmail.com>
Reply-To: Yassine Oudjana <y.oudjana@protonmail.com>
Subject: Re: [PATCH v6 2/4] leds: Add driver for Qualcomm LPG
Message-ID: <MhLF908GTTNiXzyq2bkuFfK30ETPKJrYqVSGyeT4rY@cp4-web-038.plabs.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On Wed, 21 Oct 2020 13:12:22 -0700 Bjorn Andersson wrote:
> The Light Pulse Generator (LPG) is a PWM-block found in a wide range of
> PMICs from Qualcomm. It can operate on fixed parameters or based on a
> lookup-table, altering the duty cycle over time - which provides the
> means for e.g. hardware assisted transitions of LED brightness.
>=20
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>=20
> Changes since v5:
> - Make sure to not used the state of the last channel in a group to
> determine if the current sink should be active for all channels in the
> group. - Replacement of unsigned -1 with UINT_MAX
> - Work around potential overflow by using larger data types, instead of
> separate code paths - Use cpu_to_l16() rather than hand rolling them
> - Minor style cleanups
>=20
>  drivers/leds/Kconfig         |    9 +
>  drivers/leds/Makefile        |    1 +
>  drivers/leds/leds-qcom-lpg.c | 1190 ++++++++++++++++++++++++++++++++++
>  3 files changed, 1200 insertions(+)
>  create mode 100644 drivers/leds/leds-qcom-lpg.c

Works well on the Xiaomi Mi Note 2 (msm8996pro/pmi8996).

Tested-by: Yassine Oudjana <y.oudjana@protonmail.com>

Regards,
Yassine

