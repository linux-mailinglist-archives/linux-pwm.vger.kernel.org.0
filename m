Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD42774CAB
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 23:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236278AbjHHVOL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 17:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236292AbjHHVOC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 17:14:02 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4089014FA28
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 12:18:12 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3176a439606so4631569f8f.3
        for <linux-pwm@vger.kernel.org>; Tue, 08 Aug 2023 12:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691522290; x=1692127090;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eAR8OwHxneGOD6cI9OMaaTZwonF32CaBU6KMe777AfQ=;
        b=GYb0KE38yc0513D306z6euTVYEtRDsXyJDYJF9xtzTY/iEpzNUqk5aCn/pp2gJQwtu
         Aws838RXhY/e2sxx19cqhctw8drI/MWis2wokpmhDIwjXXL7HZSSMiXg/7OEf6UZ13eS
         dPgSxsdTZmbA4yuHH5q/CAV2H2A68dCDhiDSpCbs6WnZFMr2NOmODgZbEB3E/q0R+2Ty
         BaIxfWrSu9gbS3kGfz+jUQpxTuFXliL8TMJ3dQ4mCBas+jF0SO4Nukmpq2qfdke46m0+
         9iqzI4avsA6eYVbZaECiZ9YXE4dtDvNwcfOS6nJIUG6SJG8/dzyLkfKjEKdLUkEZHptA
         W9kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691522290; x=1692127090;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eAR8OwHxneGOD6cI9OMaaTZwonF32CaBU6KMe777AfQ=;
        b=YfT15GzAKs6zi5Lbe48OZX6H0V4O6YcaMwqsibEAsK42nMPhOIz2lOZ/LV7RSywlRg
         TZyiDT3CI0rfeH+D8t1l0HVkQHo5gbInXYVsb1YYjhzhBI6Xn9VXJk/qN/ak7YFh4yCr
         pfYhz8X/sA93KzvfihoMyg/C8gphR544k6fcej4Ha+AUDhRpj03r7OBbIv+ncw/OwjIu
         ghB5PCfNco5ETwPPmPtvKeyg+ZRkimw99taOY/EG3eZ6lZzfm/uEM9Q6HbqG0oeksKQ0
         qwQ3W3Tp4br7qompTQXfaI7lAsYNO5ja0eOwCH0Z1Pct7z8GyArZm1qd8a4CbIf0QeTK
         Oikg==
X-Gm-Message-State: AOJu0YyvC6eUTH09ZwbDH1liKwLH9Bw5DZdiXVTlYjubaDMufpszPeCe
        hPBxkUh/Pv6gb2u8G5I4QFvu367pwgbTCMENtGo=
X-Google-Smtp-Source: AGHT+IFwUhkdpyDx6NkneWEHJHizkzu6HcS0X+J4bhSttR+5Zomkjk6WEZyH/sBch9W5BL8lMAf1TrUQ7vQD8+K5TGU=
X-Received: by 2002:a5d:6341:0:b0:30f:c42e:3299 with SMTP id
 b1-20020a5d6341000000b0030fc42e3299mr270874wrw.60.1691522289657; Tue, 08 Aug
 2023 12:18:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5d:4536:0:b0:317:75fc:c5d6 with HTTP; Tue, 8 Aug 2023
 12:18:09 -0700 (PDT)
From:   AREF ABDULQADER <abdulqaderaref115@gmail.com>
Date:   Tue, 8 Aug 2023 20:18:09 +0100
Message-ID: <CAJNCi-xscokmZ7kVNPZ8oLXwt=fw4XFPBSKu0XQG9yEg_AP2wQ@mail.gmail.com>
Subject: we can meet in dubai
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.4 required=5.0 tests=BAYES_50,DEAR_FRIEND,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Dear friend
my name is Mohamed Abdul please send me your what-sap number for easy
communication i have millions of dollars to invest
thanks
Mohamed Abdul
