Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEA83CB40F
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Oct 2019 06:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388021AbfJDE7y (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 4 Oct 2019 00:59:54 -0400
Received: from mx1.ucr.edu ([138.23.248.2]:1741 "EHLO mx1.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387872AbfJDE7x (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 4 Oct 2019 00:59:53 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 Oct 2019 00:59:53 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1570165194; x=1601701194;
  h=mime-version:from:date:message-id:subject:to;
  bh=ql44aBwf8muduY7E8woRGM6sMLEeHBMPetACIWQG9tI=;
  b=coqY9aqs8mWi2XCslKEwc2M6IY1m493OaIKsEcQW7ZPglfarNLf6d9k/
   jI8mcW8nu3BQQ11TeHLkTm2YOvYfnRc0qLzS6iFBWr2Gy3JEVYatSZKPE
   fiMDAL4D8RLbBh65J7KK89Vfd3Ha5trfMfwU2eyElAxcY7hlPE1YlFZbQ
   QBZkgu56KTpH+FRzB/o3Pj9qY69yxxUZoHn6mkeWjvsDnYprJ2DAy+KMb
   9/LTpNmJPzFsbWHa9m1kRE65tlyxgtDOB6mELwpqv+hGdMooWts21Wehl
   MpGnNEGy/P/VkoLob8ECM7GqMuY19jkKOdPUqBTnGM/7T+TqKuSkA7Akb
   A==;
IronPort-SDR: zpjGLrfAyIuwmuhlxuJaZ971SGgODGKHacnU+xqD53sCuhSj6L5S4T9+S2iAmJY41GHjkBLln+
 DJP4TXhp2N1GIWS2/8HnH6+LKjW27RgAXwJgfh0CSWpC7fj6UYaSswm1tn/g3KXghE7u871mRE
 r4HDtyooCDkfIpMCkylSzVDOMUVlTkhCxsHA5a7TllZGfwH2TeVgmGNJRFn6qRyB6+QEqpxiZN
 Nsmp7KbEqt0tjlwYTBTpTrPe1w8dyvcR74PDfY5IQW3iVez9tZnLMF6MyFApQzBkFWfOPtZkZZ
 W08=
IronPort-PHdr: =?us-ascii?q?9a23=3ARyDNKh95QCSJ7/9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B+0uwUIJqq85mqBkHD//Il1AaPAdyAra8cwLCM+4nbGkU4qa6bt34DdJEeHz?=
 =?us-ascii?q?Qksu4x2zIaPcieFEfgJ+TrZSFpVO5LVVti4m3peRMNQJW2aFLduGC94iAPER?=
 =?us-ascii?q?vjKwV1Ov71GonPhMiryuy+4ZLebxhGiTanYb5+MBq6oRvPusILnYZsN6E9xw?=
 =?us-ascii?q?fTrHBVYepW32RoJVySnxb4+Mi9+YNo/jpTtfw86cNOSL32cKskQ7NWCjQmKH?=
 =?us-ascii?q?0169bwtRbfVwuP52ATXXsQnxFVHgXK9hD6XpP2sivnqupw3TSRMMPqQbwoXz?=
 =?us-ascii?q?mp8rxmQwH0higZKzE58XnXis1ug6JdvBKhvAF0z4rNbI2IKPZyYqbRcNUHTm?=
 =?us-ascii?q?RDQ8lRTTRMDYy8YYUBDOQPIPhWoJXmqlsSsRezHxWgCP/zxjJKgHL9wK000/?=
 =?us-ascii?q?4mEQHDxAEvHdMOsXXUrNXoM6cZTOO6zKnSwjXCcvhb3jf86YnIch87oPGAQa?=
 =?us-ascii?q?58fMTKxEkyCwzFlE+cppL4MDOIz+kAtXWQ4el4Ve+3lWIrtwV8riKsy8oskI?=
 =?us-ascii?q?XFmJ4Zx1Pe+Sln3Io5Odu1Q1Nhb9G+CptfrSSaOpNzQsMlXm5npj43yqYDuZ?=
 =?us-ascii?q?6nZCgKz4knxwLHZ/yHbYeI5hXjWf6UIThihXJlfKuzhxKw8US90+H8WNe43E?=
 =?us-ascii?q?pWoiZfndnMsXcN1xPX6seZUPdy4kCh2TOX2wDS7OFLP1w0mLLFJ5I9xrM8jJ?=
 =?us-ascii?q?kevETZEiPohEn7j7Waels49uS08+jnZ6/ppp6YN496kAH+NaEul9S/AOU5Mg?=
 =?us-ascii?q?gBRWmb9fig2LDt5kD5XalFjucsnqbHrZ/aONwXprSlDA9NzoYj9xG/Ai+i0N?=
 =?us-ascii?q?QZm3kHMV1EdAufj4nnPlHDO+74DfihjFS2ijtrxO7JPqfnAprTKnjPirDhfa?=
 =?us-ascii?q?xy6x0U9A1m49lV/ZNfB/kuKen1W0Lr/IjWBxUjMge5henuE9N825k2Qn7JCa?=
 =?us-ascii?q?icZueajV+J6/g1MqG2aYMUvjm1f+Ql5vP0l25/g1IRfK+m9ZQSYXG8WP9hJh?=
 =?us-ascii?q?PdKUfzj+AiFWoLuAd7b3LsiVLKBSMVZHK/XqQxozI8BYSnAq/bS4ainaCb2y?=
 =?us-ascii?q?G6DttaazYCQnWFAXbtes2vXO4RZSaTJIc1lzcDTKWsT44nkwqysVSg47ViJ+?=
 =?us-ascii?q?vQvCYfsMSnnPFx6v3akx0o+HRICN6SzmzFG2hwk3MBQTMs0eZjplZy11qryr?=
 =?us-ascii?q?Q+iPtdQ5gb4/JPTxd/LYHZ5/J1Bsq0WQ/beNqNDlG8TZHuBTA3U8J02MMLOB?=
 =?us-ascii?q?xVAMnnixyG2iOrB7ockfqQGJsu97jRx3zgYc16zjKO0KgnkkljS9FKcG6rnK?=
 =?us-ascii?q?hy8yDXBpXViAOYkaiwfKgR1SKL832MiSKKvUdFQEtzXL/DUHQ3eETbt5L661?=
 =?us-ascii?q?nEQrvoDq4odkNzyc+TN60CU9zgix0SVvfiKcnYekq6gCGtDgzOy7+ROs6iUG?=
 =?us-ascii?q?UQ2irMFQA/lAYctSKNLg84CQ+quCTDByYoGF7yNRDC6+57/UK6XE8pyEm4b0?=
 =?us-ascii?q?Rgn+6k6B4chKTEENsO1ahCtSs8/WYnVG2h1s7bXoLT7zFqe79RNJZkuA9K?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2HiAgD4zpZdgMjQVdFlDhABBhKFRDO?=
 =?us-ascii?q?ETI5fhRcBmBgBCAEBAQ4vAQGEOwOCSiM4EwIDCQEBBQEBAQEBBQQBAQIQAQE?=
 =?us-ascii?q?JDQkIJ4VCgjopAYNVEXwPAiYCJBIBBQEiATSFC6FbgQM8iyaBMoQMAYRYAQk?=
 =?us-ascii?q?NgUgSeiiMDoIXg25zh1GCWASBNwEBAZUrllIBBgKCERQDjFGIRBuCKpcWjiu?=
 =?us-ascii?q?ZSg8jgUaBezMaJX8GZ4FPTxAUgVsXjWgEAVYkkXsBAQ?=
X-IPAS-Result: =?us-ascii?q?A2HiAgD4zpZdgMjQVdFlDhABBhKFRDOETI5fhRcBmBgBC?=
 =?us-ascii?q?AEBAQ4vAQGEOwOCSiM4EwIDCQEBBQEBAQEBBQQBAQIQAQEJDQkIJ4VCgjopA?=
 =?us-ascii?q?YNVEXwPAiYCJBIBBQEiATSFC6FbgQM8iyaBMoQMAYRYAQkNgUgSeiiMDoIXg?=
 =?us-ascii?q?25zh1GCWASBNwEBAZUrllIBBgKCERQDjFGIRBuCKpcWjiuZSg8jgUaBezMaJ?=
 =?us-ascii?q?X8GZ4FPTxAUgVsXjWgEAVYkkXsBAQ?=
X-IronPort-AV: E=Sophos;i="5.67,254,1566889200"; 
   d="scan'208";a="12059797"
Received: from mail-lj1-f200.google.com ([209.85.208.200])
  by smtp1.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Oct 2019 21:52:47 -0700
Received: by mail-lj1-f200.google.com with SMTP id i18so1386307ljg.14
        for <linux-pwm@vger.kernel.org>; Thu, 03 Oct 2019 21:52:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=UonwauBUbF5jJCMbv+kEyggRBo1MYeaIpr/rVjEka4g=;
        b=p36kkhaaEQp6ZhAwRgHRrJFLiZ/rj+iUzqu1zn/sqvRB5Tk5JbnlJpg9LguRS49l6e
         tSguRSB7GaFG0Q2kZSbKVz8i6V9+deAMrKVIWBCtG1QNqt6Fjf8fuqabfmZnWWuhR+db
         oWhhEeu3BbgrdYaPCMtnDn3oAP7N5SOLtTJfyh4nvV+BqDwG0PffshyB66ztx9WRtxKy
         s1aebZam95zRhA3ROIBdkB60S74FDA8DkJ1Z4xAqN3J75snPqyoFFlwGPO0WLUexC1cI
         xQOQWTchidpUqJ6ZHvNiOdQNt7Eon44Iun56pZl4Mg4Dam54qiK2d9tkgdiM3diz4jVC
         yM3A==
X-Gm-Message-State: APjAAAVwIaiQeyVul7IFsJ5IH7kwleeg9c5LEhWeKP/837orc3jmrwFb
        Hf4nSuBw1gR4gkPcH88mNrJoiuC0FOr9LNH4XTwK9Clm2761Q+YMQM1+K3MYAaK7Sk0fPjxA353
        JMD9nSEu6eILh/Ye/G7QF5D9grQkOT9oP/XIJpw==
X-Received: by 2002:a19:4347:: with SMTP id m7mr7417796lfj.146.1570164764937;
        Thu, 03 Oct 2019 21:52:44 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxQwQ4yv8ZIWgEbfBVR+NQnXGTuto6AhZqOSD61PfrwsPbsqTELSWEjRUHKiie8C8KsIwGEinKXPs2u+mEFOfQ=
X-Received: by 2002:a19:4347:: with SMTP id m7mr7417782lfj.146.1570164764695;
 Thu, 03 Oct 2019 21:52:44 -0700 (PDT)
MIME-Version: 1.0
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Date:   Thu, 3 Oct 2019 21:52:31 -0700
Message-ID: <CABvMjLSR9kFJpU19OX8Us4jPQ9vuTtNR571Njn_gqqpb-=hdCQ@mail.gmail.com>
Subject: Potential uninitialized variables in pwm: stm32-lp
To:     Fabrice Gasnier <fabrice.gasnier@st.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-pwm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zhiyun Qian <zhiyunq@cs.ucr.edu>,
        Chengyu Song <csong@cs.ucr.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi All:

drivers/pwm/pwm-stm32-lp.c:

Variable "val" and "prd" in function stm32_pwm_lp_get_state() could be
uninitialized
if regmap_read() returns -EINVAL. But it's directly used later without
the return check,
which is potentially unsafe.

Also, we cannot simply return -EINVAL in stm32_pwm_lp_get_state() because the
return type is void.

Thanks for your time to check this case.
-- 
Kind Regards,

Yizhuo Zhai

Computer Science, Graduate Student
University of California, Riverside
