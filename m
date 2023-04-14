Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 292E06E208A
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Apr 2023 12:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjDNKR2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 14 Apr 2023 06:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjDNKR1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 14 Apr 2023 06:17:27 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5469119D
        for <linux-pwm@vger.kernel.org>; Fri, 14 Apr 2023 03:17:22 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id j12so709258wrd.2
        for <linux-pwm@vger.kernel.org>; Fri, 14 Apr 2023 03:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681467441; x=1684059441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=As5NVC8l1EGrPg+SbJL3MRZ+taIAWv4f/jFh7i2FOso=;
        b=DGAGU6J1ULKtfsHVqSnEHk5KJGNW3M6etIbctLTV13QV7eSKYJIq8zsHJejep8awgy
         DOv4DxEXYm4f+kOg69hFzku+sBfRRgfkIQL1l44ybNaEIwc80fNxXi7QNGOr4b6gWRrE
         gZdme8ECOZFPWY9gj/dXC3mZBhwvGJqK8g5kKGOiBlp2mRtSpKwEU4HB1GeQMQ7eC3Qm
         GDIUNjObGPDZQjkdofCPbvDJnNxykJDICp2p8v4CMURy4BWZzxlztEfvEb7HWb8jyf8g
         0NnaJ8FS9tC+h1eM13CJvmyJLN7Bbca1uXFgvpb8cGQl/jjYoldCo9UCBnag+5KMTcqk
         cZpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681467441; x=1684059441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=As5NVC8l1EGrPg+SbJL3MRZ+taIAWv4f/jFh7i2FOso=;
        b=giZvmqt5RZj7Vt6w2F+E3Et6/KJ10X4lrqdcRkuDfXTEv3mjdw/RY/MvDSeCqf/tWG
         fl8nRfoDC8GIoJcAv9k9L8qJPslYDdE0H+lrUpfB4Gnvkhw3+xlk8osElgKns3DrcFEP
         e4iv+eyHv+YTtBTCKgVc+V64/Xvj01E6JlotEEucO2KNorioUyKnnn3gj9Df9/mnnYDh
         7Kl0KPGw6xo1HJLFC3tz0m5BoDhEGiETyWtCoOTR6O2tQLtekZBNpgOrvA9syxdzz2FH
         s3rU6kFQ3Lh8RMbXIGAY9iNlv/z/pUTH9iz1oXeJuVlecifKLpu1Yt+s0Kts9EAs001E
         GsYg==
X-Gm-Message-State: AAQBX9f/aMdnFNyVxB/F9MOIONEUQPW/aFoarCSDW6nug6fiAfE/upaj
        PFyx4mYdd+if81ESVqVv0QA2nNO4gpEruSI/zHI=
X-Google-Smtp-Source: AKy350a3TxrY4Teid51+ZzdnGoh9nKenslkvgqAhEKeGVFKx4VGn+o3yxZCzW1w6EiYeFKxuH13e3STk5wUiuM42FOA=
X-Received: by 2002:adf:d847:0:b0:2e8:4519:ee98 with SMTP id
 k7-20020adfd847000000b002e84519ee98mr1066214wrl.13.1681467440494; Fri, 14 Apr
 2023 03:17:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230413122947.428134-1-thierry.reding@gmail.com> <20230413205541.bqmtdfq7jbqtsm46@pengutronix.de>
In-Reply-To: <20230413205541.bqmtdfq7jbqtsm46@pengutronix.de>
From:   Thierry Reding <thierry.reding@gmail.com>
Date:   Fri, 14 Apr 2023 12:17:09 +0200
Message-ID: <CA+PwDYeXjAZ4XW=Twz32dLjWpSRdj7+s_tk8zTbpYujwm-C_PA@mail.gmail.com>
Subject: Re: [PATCH] pwm: Remove unused radix tree
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org
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

On Thu, Apr 13, 2023 at 10:55:41PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> On Thu, Apr 13, 2023 at 02:29:47PM +0200, Thierry Reding wrote:
> > The radix tree's only use was to map PWM channels to the global number
> > space. With that number space gone, the radix tree is now unused, so it
> > can simply be removed.
> >
> > Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
>
> Assuming you put that on top of my patch removing pwm_request() and
> pwm_free() (+ the fixes you mentioned in reply to it):
>
> Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Yeah, that's exactly what I did. Thanks for the quick review. I've
applied this now.

Thierry
