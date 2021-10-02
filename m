Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D15A41FE01
	for <lists+linux-pwm@lfdr.de>; Sat,  2 Oct 2021 22:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbhJBUZD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 2 Oct 2021 16:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbhJBUZD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 2 Oct 2021 16:25:03 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43D0C0613EC
        for <linux-pwm@vger.kernel.org>; Sat,  2 Oct 2021 13:23:16 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id y26so53461795lfa.11
        for <linux-pwm@vger.kernel.org>; Sat, 02 Oct 2021 13:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=j7Tp35vbwWyFXbHCr1JA0SMtzBP/ZW1afkuz0W8CPU0=;
        b=GjISiqNfvM1B4svAxa12vlbW3/C/MJYS0qHPx3z8L83O2sr1sJ90NI5Ecd94WvGzm5
         0KwHzDtXkady41bv6UbgSP3KPUehM1/eGcVJkPjixmsvD92kfj87gBe1NurPbS8yLbWZ
         X54KqyeqjBrJPVneiQHFK3zcgyDuZ/93+/Mod8hDqu0hZo+PotH0tT745qIZjWJoKRbH
         IlaDEFTvR6hn4365Y4kL62GSBk5iCaNnnfvGxacQNx+ozUOHLphgVDEl+Y1PZ+NP5leN
         rk3D54bIGFi2cSwN18+ccFlAm2fSLwf44PxFlDZVcqDvx0zqsEZWafHn39pk+DSQYnbN
         jXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=j7Tp35vbwWyFXbHCr1JA0SMtzBP/ZW1afkuz0W8CPU0=;
        b=hBy5lqLtkGOkTzwaOqDF39OafkQ7Z+0tEN5oONzDn2iV0v2geSac3fyGJQh+QxZynN
         TEnFAfNLeEnKp/EDjce5g8UFI4YOLxdcAHuJQWNhcg1E8bYXfYNSCWOdx2My7tsR2Ztf
         nsr+wQdNp8XSJjSaYSjWL+dciwtpTIvQJgKpH1DDkZsDroGBAIqV86B/NRXyNJe0ecBh
         /dYaqif64bpj4gcPbcgjXO32D4fqvSvydQqogWfaEn6VRcB/vd31fq7959lNUbkFJrZP
         T6m6SnNFOXKpBdIUBiMw0bJuQS9cs5CYHa04sAxZY+Xuw9I8+yVIZkCbXGAo9DnhSM4n
         RzHA==
X-Gm-Message-State: AOAM533znWrR38UO/BfrsV7heZZOTc+5ge/moeLVAjYbRTgGCBBflLzr
        o8cfL/ITcnGSusSEPH+R1Rr+UoOJiXXc0QXrAgI=
X-Google-Smtp-Source: ABdhPJz/c/cbfuiLK+6l8Lt5bgsYX9ILwtslLrd8oJE5rs4HmRDkCJ15VCkCyN5+TNJihbEOax8xgJsQOpoXVLeZoa0=
X-Received: by 2002:a2e:5c08:: with SMTP id q8mr5511580ljb.304.1633206195017;
 Sat, 02 Oct 2021 13:23:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6504:245:0:0:0:0 with HTTP; Sat, 2 Oct 2021 13:23:14
 -0700 (PDT)
From:   Liu Gaoshan <pn509017@gmail.com>
Date:   Sat, 2 Oct 2021 13:23:14 -0700
Message-ID: <CAA4y2-bSJtOTTVCsmWAGOQ0SyQmn+Z5X2eR3GdUNPrHRzDfDrg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

-- 
I need your urgent assistance in partnership in Re-profilling funds
