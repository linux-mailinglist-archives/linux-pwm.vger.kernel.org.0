Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0BF6F287D
	for <lists+linux-pwm@lfdr.de>; Sun, 30 Apr 2023 12:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjD3KmF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 30 Apr 2023 06:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjD3KmD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 30 Apr 2023 06:42:03 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E5A10DB;
        Sun, 30 Apr 2023 03:42:02 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-3ef5b5d322dso17496681cf.2;
        Sun, 30 Apr 2023 03:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682851321; x=1685443321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A3mT7vVrR/9Qwo2tYrOVKAIeZ1bgySQ/ECkktq9ADN4=;
        b=UeZLh3m5vX6lg5LZ5bHVGViC9GATumJoOvQSJUNVf8ZUxp/fKyaQ46DOT6Fndtb7B7
         +qf0XsT6A33ai6Ci3iSE7uCb6x1sPJzNfcHFIcr7KRpRvnbGJFme53RzATZD77HWG/cV
         BO7hoKtr2Xha2Iweftmbx5kPS+2imBBIea/3mgILuxchVPgN7/gmJIBUCw6LHZcqwdz5
         yXwTKSB2+DoYMUcded69cXlvmIX8pN0XffNNVHSq2Y8hvSoKR9PrP7boZHB32l5Xa3Jb
         arBP84XpIzRb/7TqVYvJrCBKYBGFRX/9U6/V3FV2QGL06A3Bo/dVSZP3Zq8tlqabvw1s
         JIIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682851321; x=1685443321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A3mT7vVrR/9Qwo2tYrOVKAIeZ1bgySQ/ECkktq9ADN4=;
        b=CvqH0Z3jaoMHB+kYNYAdkfY1z0zSf6fQl/1Z55DoJhYVCwq0rbIRHFrvYCJ6EQPDIU
         UcD6sT6w0G7I0g42tH9pyb0oz4/DjTSNjzanIR1FaUmnDKZAmLCq+SJz820v24OPK/T+
         +zr/ialyWc7nBJ9HNyQ6CO15e97XN5KOOk/VSIBzafw6YeAOvhhiHnDk9QxeWa/L09L5
         NlxptXCThu0IGMU3pSiMrfZPZzWy5NYKQGGRPTJDSUlTnqD6nFIDXQw8X1M7QMizArEU
         sZzaDNBVcUIEMtJVUK0TQQTAXzysdeNqowXf27mY0bbdkMFL+j8OBmcLUSDfE00qPI/4
         ThPw==
X-Gm-Message-State: AC+VfDxKU7f0TXKqWZ2TfTDbY3w/XC6+x6ObH+yGd4GsDqnvmU0nRqDJ
        U/c0rwjEknYvCxg8YxR3BbE21PyinbgWJUpPtxmI9MblqHCRU35P
X-Google-Smtp-Source: ACHHUZ4fR+H4P3arOYwcX1MlmZXXRNVW7qeI2R7jC9PyaqeYmICNwS/iVsjr8tUNa39YU9DZbBIELFngcsIznJxCZw8=
X-Received: by 2002:a05:622a:1716:b0:3ef:28dc:fdd0 with SMTP id
 h22-20020a05622a171600b003ef28dcfdd0mr16980380qtk.44.1682851321556; Sun, 30
 Apr 2023 03:42:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230429181551.98201-1-hdegoede@redhat.com> <20230429181551.98201-13-hdegoede@redhat.com>
In-Reply-To: <20230429181551.98201-13-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 30 Apr 2023 13:41:25 +0300
Message-ID: <CAHp75Vc0NLYSfMDzOjYW59poAsdkftAUQgbUXU4XiTdYWpjn_w@mail.gmail.com>
Subject: Re: [PATCH 12/19] platform/x86: lenovo-yogabook: Abstract kbd
 backlight setting
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Yauhen Kharuzhy <jekhor@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sat, Apr 29, 2023 at 9:16=E2=80=AFPM Hans de Goede <hdegoede@redhat.com>=
 wrote:
>
> Abstract kbd backlight setting.

> While at it also replace the ugly
> uint8_t type with u8.

I believe this is a fragile selling point. The more important one is
do we have consistency in the code (i.e. u8 everywhere, or uint8_t
everywhere)? If so, I don't see why uint8_t is ugly.

> This is a preparation patch for making lenovo-yogabook-wmi also work
> on the Android version of the Yoga Book 1 which does not have a WMI
> interface to deal with toggling the keyboard half between
> touch-keyboard and wacom-digitizer mode.


--=20
With Best Regards,
Andy Shevchenko
